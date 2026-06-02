import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mashmaster/calc/general_calc.dart';
import 'package:mashmaster/calc/hydrometer_calc.dart';
import 'package:mashmaster/calc/refractometer_calc.dart';
import 'package:mashmaster/i18n/generated/translations.g.dart';

enum _GeneralCalcTab { abv, refractometer, hydrometer }

class HomeScreenGeneralCalc extends StatefulWidget {
  const HomeScreenGeneralCalc({super.key});

  @override
  State<HomeScreenGeneralCalc> createState() => _HomeScreenGeneralCalcState();
}

class _HomeScreenGeneralCalcState extends State<HomeScreenGeneralCalc> {
  _GeneralCalcTab _tab = _GeneralCalcTab.abv;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: SegmentedButton<_GeneralCalcTab>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(
                value: _GeneralCalcTab.abv,
                label: Text(t.general_screen.tabs.abv),
              ),
              ButtonSegment(
                value: _GeneralCalcTab.refractometer,
                label: Text(t.general_screen.tabs.refractometer),
              ),
              ButtonSegment(
                value: _GeneralCalcTab.hydrometer,
                label: Text(t.general_screen.tabs.hydrometer),
              ),
            ],
            selected: {_tab},
            onSelectionChanged: (s) => setState(() => _tab = s.first),
          ),
        ),
        Expanded(
          child: switch (_tab) {
            _GeneralCalcTab.abv => const _AbvCalcBody(),
            _GeneralCalcTab.refractometer => const _RefractometerBody(),
            _GeneralCalcTab.hydrometer => const _HydrometerBody(),
          },
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// ABV / Calorie calculator (existing logic, extracted into its own widget)
// ---------------------------------------------------------------------------

class _AbvCalcBody extends StatefulWidget {
  const _AbvCalcBody();

  @override
  State<_AbvCalcBody> createState() => _AbvCalcBodyState();
}

class _AbvCalcBodyState extends State<_AbvCalcBody> {
  GravityUnit _unit = GravityUnit.plato;
  final TextEditingController _ogCtrl = TextEditingController();
  final TextEditingController _fgCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ogCtrl.addListener(() => setState(() {}));
    _fgCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _ogCtrl.dispose();
    _fgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final og = _parse(_ogCtrl.text);
    final fg = _parse(_fgCtrl.text);
    final stats = (og == null || fg == null)
        ? null
        : GeneralCalculation.fromGravities(og: og, fg: fg, unit: _unit);

    final unitSuffix = _unit == GravityUnit.plato
        ? t.general_screen.units.plato
        : t.general_screen.units.sg;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionLabel(text: t.general_screen.section.input),
          const SizedBox(height: 8),
          SegmentedButton<GravityUnit>(
            segments: [
              ButtonSegment(
                value: GravityUnit.plato,
                label: Text(t.general_screen.units.plato),
              ),
              ButtonSegment(
                value: GravityUnit.specificGravity,
                label: Text(t.general_screen.units.sg),
              ),
            ],
            selected: {_unit},
            onSelectionChanged: (s) => setState(() => _unit = s.first),
          ),
          const SizedBox(height: 16),
          _NumberField(
            controller: _ogCtrl,
            labelText: t.general_screen.labels.og,
            hintText: _unit == GravityUnit.plato
                ? t.general_screen.hint.og_plato
                : t.general_screen.hint.og_sg,
            suffixText: unitSuffix,
          ),
          const SizedBox(height: 12),
          _NumberField(
            controller: _fgCtrl,
            labelText: t.general_screen.labels.fg,
            hintText: _unit == GravityUnit.plato
                ? t.general_screen.hint.fg_plato
                : t.general_screen.hint.fg_sg,
            suffixText: unitSuffix,
          ),
          const SizedBox(height: 24),
          _AbvResultCard(stats: stats),
          const SizedBox(height: 16),
          _InfoFooter(text: t.general_screen.info),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Refractometer calculator
// ---------------------------------------------------------------------------

class _RefractometerBody extends StatefulWidget {
  const _RefractometerBody();

  @override
  State<_RefractometerBody> createState() => _RefractometerBodyState();
}

class _RefractometerBodyState extends State<_RefractometerBody> {
  bool _fermented = false;
  final TextEditingController _ogCtrl = TextEditingController();
  final TextEditingController _brixCtrl = TextEditingController();
  final TextEditingController _cfCtrl = TextEditingController(text: '1,04');

  @override
  void initState() {
    super.initState();
    _ogCtrl.addListener(() => setState(() {}));
    _brixCtrl.addListener(() => setState(() {}));
    _cfCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _ogCtrl.dispose();
    _brixCtrl.dispose();
    _cfCtrl.dispose();
    super.dispose();
  }

  RefractometerResult? _compute() {
    final brix = _parse(_brixCtrl.text);
    final cf = _parse(_cfCtrl.text);
    if (brix == null || cf == null) return null;

    if (_fermented) {
      final og = _parse(_ogCtrl.text);
      if (og == null) return null;
      return RefractometerCalculation.fermented(
        ogPlato: og,
        brixWri: brix,
        correctionFactor: cf,
      );
    } else {
      return RefractometerCalculation.unfermented(
        brixWri: brix,
        correctionFactor: cf,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final result = _compute();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CheckboxListTile(
            value: _fermented,
            onChanged: (v) => setState(() => _fermented = v ?? false),
            title: Text(t.refractometer_screen.fermented_wort),
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
          ),
          if (_fermented) ...[
            _NumberField(
              controller: _ogCtrl,
              labelText: t.refractometer_screen.labels.og,
              hintText: t.refractometer_screen.hint.og,
              suffixText: '°P',
            ),
            const SizedBox(height: 12),
          ],
          _NumberField(
            controller: _brixCtrl,
            labelText: t.refractometer_screen.labels.brix,
            hintText: t.refractometer_screen.hint.brix,
          ),
          const SizedBox(height: 12),
          _NumberField(
            controller: _cfCtrl,
            labelText: t.refractometer_screen.labels.correction_factor,
            hintText: t.refractometer_screen.hint.correction_factor,
          ),
          const SizedBox(height: 24),
          _RefractometerResultCard(result: result, fermented: _fermented),
          const SizedBox(height: 16),
          _InfoFooter(text: t.refractometer_screen.info),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Hydrometer temperature correction
// ---------------------------------------------------------------------------

class _HydrometerBody extends StatefulWidget {
  const _HydrometerBody();

  @override
  State<_HydrometerBody> createState() => _HydrometerBodyState();
}

class _HydrometerBodyState extends State<_HydrometerBody> {
  GravityUnit _unit = GravityUnit.plato;
  final TextEditingController _measuredCtrl = TextEditingController();
  final TextEditingController _wortTempCtrl = TextEditingController();
  final TextEditingController _calibrationTempCtrl = TextEditingController(
    text: HydrometerCorrection.defaultCalibrationTempC.toStringAsFixed(0),
  );

  @override
  void initState() {
    super.initState();
    _measuredCtrl.addListener(() => setState(() {}));
    _wortTempCtrl.addListener(() => setState(() {}));
    _calibrationTempCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _measuredCtrl.dispose();
    _wortTempCtrl.dispose();
    _calibrationTempCtrl.dispose();
    super.dispose();
  }

  double? _compute() {
    final measured = _parse(_measuredCtrl.text);
    final wortTemp = _parse(_wortTempCtrl.text);
    final calTemp = _parse(_calibrationTempCtrl.text);
    if (measured == null || wortTemp == null || calTemp == null) return null;
    return HydrometerCorrection.correct(
      measuredGravity: measured,
      unit: _unit,
      wortTempC: wortTemp,
      calibrationTempC: calTemp,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final corrected = _compute();
    final unitSuffix = _unit == GravityUnit.plato
        ? t.general_screen.units.plato
        : t.general_screen.units.sg;
    final measuredHint = _unit == GravityUnit.plato
        ? t.hydrometer_screen.hint.measured_plato
        : t.hydrometer_screen.hint.measured_sg;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SegmentedButton<GravityUnit>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(
                value: GravityUnit.plato,
                label: Text(t.general_screen.units.plato),
              ),
              ButtonSegment(
                value: GravityUnit.specificGravity,
                label: Text(t.general_screen.units.sg),
              ),
            ],
            selected: {_unit},
            onSelectionChanged: (s) => setState(() => _unit = s.first),
          ),
          const SizedBox(height: 16),
          _NumberField(
            controller: _measuredCtrl,
            labelText: t.hydrometer_screen.labels.measured_gravity,
            hintText: measuredHint,
            suffixText: unitSuffix,
          ),
          const SizedBox(height: 12),
          _NumberField(
            controller: _wortTempCtrl,
            labelText: t.hydrometer_screen.labels.temperature,
            hintText: t.hydrometer_screen.hint.temperature,
            suffixText: '°C',
          ),
          const SizedBox(height: 12),
          _NumberField(
            controller: _calibrationTempCtrl,
            labelText: t.hydrometer_screen.labels.calibration_temp,
            hintText: t.hydrometer_screen.hint.calibration_temp,
            suffixText: '°C',
          ),
          const SizedBox(height: 24),
          _HydrometerResultCard(corrected: corrected, unit: _unit),
          const SizedBox(height: 16),
          _InfoFooter(text: t.hydrometer_screen.info),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Result cards
// ---------------------------------------------------------------------------

class _AbvResultCard extends StatelessWidget {
  final BrewStats? stats;
  const _AbvResultCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final s = stats;

    return Card(
      color: scheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.general_screen.labels.abv,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: scheme.onPrimaryContainer.withValues(alpha: 0.7),
                  ),
            ),
            const SizedBox(height: 4),
            _BigNumber(
              value: s == null ? '—' : _fmtPercent(s.abv),
              unit: '%',
            ),
            const SizedBox(height: 20),
            _StatRow(
              label: t.general_screen.labels.abw,
              value: s == null ? '—' : '${_fmtPercent(s.abw)} %',
            ),
            const SizedBox(height: 16),
            _StatRow(
              label: t.general_screen.labels.calories,
              value: s == null
                  ? '—'
                  : '${_fmtNumber(s.kcalPer100ml, 1)} kcal · ${_fmtNumber(s.kjPer100ml, 1)} kJ',
              suffix: t.general_screen.per_100ml,
            ),
            const SizedBox(height: 8),
            _StatRow(
              label: t.general_screen.labels.carbs,
              value: s == null ? '—' : '${_fmtNumber(s.carbsPer100ml, 1)} g',
              suffix: t.general_screen.per_100ml,
            ),
            const SizedBox(height: 16),
            _StatRow(
              label: t.general_screen.labels.apparent_attenuation,
              value: s == null ? '—' : '${_fmtPercent(s.apparentAttenuation)} %',
            ),
            const SizedBox(height: 8),
            _StatRow(
              label: t.general_screen.labels.real_attenuation,
              value: s == null ? '—' : '${_fmtPercent(s.realAttenuation)} %',
            ),
            const SizedBox(height: 16),
            _StatRow(
              label: t.general_screen.labels.original_extract,
              value: s == null
                  ? '—'
                  : '${_fmtNumber(s.originalExtractPlato, 2)} °P',
            ),
            const SizedBox(height: 8),
            _StatRow(
              label: t.general_screen.labels.apparent_extract,
              value: s == null
                  ? '—'
                  : '${_fmtNumber(s.apparentExtractPlato, 2)} °P',
            ),
            const SizedBox(height: 8),
            _StatRow(
              label: t.general_screen.labels.real_extract,
              value: s == null
                  ? '—'
                  : '${_fmtNumber(s.realExtractPlato, 2)} °P',
            ),
          ],
        ),
      ),
    );
  }
}

class _RefractometerResultCard extends StatelessWidget {
  final RefractometerResult? result;
  final bool fermented;
  const _RefractometerResultCard({required this.result, required this.fermented});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final r = result;

    return Card(
      color: scheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.refractometer_screen.labels.gravity,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: scheme.onPrimaryContainer.withValues(alpha: 0.7),
                  ),
            ),
            const SizedBox(height: 4),
            _BigNumber(
              value: r == null ? '—' : _fmtNumber(r.gravityPlato, 1),
              unit: '°P',
            ),
            if (fermented && r != null && r.abv != null) ...[
              const SizedBox(height: 16),
              Text(
                '${t.refractometer_screen.labels.abv} ${_fmtPercent(r.abv!)}% · '
                '${t.refractometer_screen.labels.abw} ${_fmtPercent(r.abw!)}%',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: scheme.onPrimaryContainer.withValues(alpha: 0.75),
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _HydrometerResultCard extends StatelessWidget {
  final double? corrected;
  final GravityUnit unit;
  const _HydrometerResultCard({required this.corrected, required this.unit});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final scheme = Theme.of(context).colorScheme;

    final unitLabel = unit == GravityUnit.plato
        ? t.general_screen.units.plato
        : t.general_screen.units.sg;
    final value = corrected == null
        ? '—'
        : (unit == GravityUnit.plato
            ? _fmtNumber(corrected!, 1)
            : corrected!.toStringAsFixed(3));

    return Card(
      color: scheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.hydrometer_screen.labels.corrected_gravity,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: scheme.onPrimaryContainer.withValues(alpha: 0.7),
                  ),
            ),
            const SizedBox(height: 4),
            _BigNumber(value: value, unit: unitLabel),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared widgets
// ---------------------------------------------------------------------------

class _BigNumber extends StatelessWidget {
  final String value;
  final String unit;
  const _BigNumber({required this.value, required this.unit});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: scheme.onPrimaryContainer,
              fontWeight: FontWeight.w600,
            ),
        children: [
          TextSpan(text: value),
          TextSpan(
            text: ' $unit',
            style: TextStyle(
              fontSize: 22,
              color: scheme.onPrimaryContainer.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
    );
  }
}

class _NumberField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? suffixText;
  const _NumberField({
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.suffixText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
      ],
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,
        suffixText: suffixText,
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final String? suffix;
  const _StatRow({required this.label, required this.value, this.suffix});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final labelColor = scheme.onPrimaryContainer.withValues(alpha: 0.75);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: labelColor,
                ),
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: scheme.onPrimaryContainer,
                fontWeight: FontWeight.w600,
              ),
        ),
        if (suffix != null) ...[
          const SizedBox(width: 6),
          Text(
            suffix!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: labelColor,
                ),
          ),
        ],
      ],
    );
  }
}

class _InfoFooter extends StatelessWidget {
  final String text;
  const _InfoFooter({required this.text});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurfaceVariant;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline, size: 18, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color),
          ),
        ),
      ],
    );
  }
}

String _fmtPercent(double v) => v.toStringAsFixed(1);

String _fmtNumber(double v, int digits) {
  if (v.abs() >= 100) return v.toStringAsFixed(0);
  return v.toStringAsFixed(digits);
}

double? _parse(String raw) {
  final cleaned = raw.replaceAll(',', '.').trim();
  if (cleaned.isEmpty) return null;
  final v = double.tryParse(cleaned);
  if (v == null || v < 0) return null;
  return v;
}
