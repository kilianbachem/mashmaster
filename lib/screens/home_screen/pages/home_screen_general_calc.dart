import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mashmaster/calc/carbonation_calc.dart';
import 'package:mashmaster/calc/general_calc.dart';
import 'package:mashmaster/calc/hydrometer_calc.dart';
import 'package:mashmaster/calc/refractometer_calc.dart';
import 'package:mashmaster/calc/serving_pressure_calc.dart';
import 'package:mashmaster/data/beer_styles.dart';
import 'package:mashmaster/i18n/generated/translations.g.dart';

class HomeScreenGeneralCalc extends StatelessWidget {
  const HomeScreenGeneralCalc({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: 5,
      child: Column(
        children: [
          Material(
            color: scheme.surface,
            child: TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              tabs: [
                Tab(text: t.general_screen.tabs.abv),
                Tab(text: t.general_screen.tabs.refractometer),
                Tab(text: t.general_screen.tabs.hydrometer),
                Tab(text: t.general_screen.tabs.carbonation),
                Tab(text: t.general_screen.tabs.serving_pressure),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                _AbvCalcBody(),
                _RefractometerBody(),
                _HydrometerBody(),
                _CarbonationBody(),
                _ServingPressureBody(),
              ],
            ),
          ),
        ],
      ),
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
// Carbonation calculator
// ---------------------------------------------------------------------------

class _CarbonationBody extends StatefulWidget {
  const _CarbonationBody();

  @override
  State<_CarbonationBody> createState() => _CarbonationBodyState();
}

class _CarbonationBodyState extends State<_CarbonationBody> {
  BeerStyle _style = beerStyles.first;
  CarbonationMethod _method = CarbonationMethod.bottleSugar;

  late final TextEditingController _targetCo2Ctrl;
  final TextEditingController _volumeCtrl = TextEditingController(text: '20');
  final TextEditingController _fermTempCtrl = TextEditingController(text: '20');
  final TextEditingController _carbTempCtrl = TextEditingController(text: '4');

  @override
  void initState() {
    super.initState();
    _targetCo2Ctrl = TextEditingController(
      text: _formatGpl(_style.minCo2GramsPerLiter),
    );
    _targetCo2Ctrl.addListener(() => setState(() {}));
    _volumeCtrl.addListener(() => setState(() {}));
    _fermTempCtrl.addListener(() => setState(() {}));
    _carbTempCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _targetCo2Ctrl.dispose();
    _volumeCtrl.dispose();
    _fermTempCtrl.dispose();
    _carbTempCtrl.dispose();
    super.dispose();
  }

  void _onStyleSelected(BeerStyle? style) {
    if (style == null) return;
    setState(() {
      _style = style;
      _targetCo2Ctrl.text = _formatGpl(style.minCo2GramsPerLiter);
    });
  }

  String _formatGpl(double v) => v.toStringAsFixed(1).replaceAll('.', ',');

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final target = _parse(_targetCo2Ctrl.text);
    final volume = _parse(_volumeCtrl.text);
    final fermTemp = _parse(_fermTempCtrl.text);
    final carbTemp = _parse(_carbTempCtrl.text);

    CarbonationSugarResult? sugarResult;
    CarbonationPressureResult? pressureResult;
    if (target != null) {
      switch (_method) {
        case CarbonationMethod.bottleSugar:
          if (volume != null && fermTemp != null) {
            sugarResult = CarbonationCalculation.bottleSugar(
              targetCo2GramsPerLiter: target,
              bottlingVolumeLiters: volume,
              peakFermentationTempC: fermTemp,
            );
          }
        case CarbonationMethod.kegSugar:
          if (volume != null && fermTemp != null) {
            sugarResult = CarbonationCalculation.kegSugar(
              targetCo2GramsPerLiter: target,
              kegVolumeLiters: volume,
              peakFermentationTempC: fermTemp,
            );
          }
        case CarbonationMethod.kegForce:
          if (carbTemp != null) {
            pressureResult = CarbonationCalculation.forcePressure(
              targetCo2GramsPerLiter: target,
              carbonationTempC: carbTemp,
            );
          }
      }
    }

    final isSugar = _method == CarbonationMethod.bottleSugar ||
        _method == CarbonationMethod.kegSugar;
    final volumeLabel = _method == CarbonationMethod.bottleSugar
        ? t.carbonation_screen.labels.bottling_volume
        : t.carbonation_screen.labels.keg_volume;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownMenu<BeerStyle>(
            initialSelection: _style,
            label: Text(t.carbonation_screen.labels.beer_style),
            expandedInsets: EdgeInsets.zero,
            onSelected: _onStyleSelected,
            dropdownMenuEntries: beerStyles
                .map((s) => DropdownMenuEntry<BeerStyle>(
                      value: s,
                      label: s.name,
                    ))
                .toList(),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              '${t.carbonation_screen.labels.style_range}: '
              '${_formatGpl(_style.minCo2GramsPerLiter)} – '
              '${_formatGpl(_style.maxCo2GramsPerLiter)} g/L',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          _NumberField(
            controller: _targetCo2Ctrl,
            labelText: t.carbonation_screen.labels.target_co2,
            hintText: _formatGpl(_style.minCo2GramsPerLiter),
            suffixText: 'g/L CO₂',
          ),
          const SizedBox(height: 16),
          _SectionLabel(text: t.carbonation_screen.labels.method),
          const SizedBox(height: 8),
          SegmentedButton<CarbonationMethod>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(
                value: CarbonationMethod.bottleSugar,
                label: Text(t.carbonation_screen.methods.bottle_sugar),
              ),
              ButtonSegment(
                value: CarbonationMethod.kegSugar,
                label: Text(t.carbonation_screen.methods.keg_sugar),
              ),
              ButtonSegment(
                value: CarbonationMethod.kegForce,
                label: Text(t.carbonation_screen.methods.keg_force),
              ),
            ],
            selected: {_method},
            onSelectionChanged: (s) => setState(() => _method = s.first),
          ),
          const SizedBox(height: 16),
          if (isSugar) ...[
            _NumberField(
              controller: _volumeCtrl,
              labelText: volumeLabel,
              hintText: t.carbonation_screen.hint.volume,
              suffixText: 'L',
            ),
            const SizedBox(height: 12),
            _NumberField(
              controller: _fermTempCtrl,
              labelText: t.carbonation_screen.labels.peak_fermentation_temp,
              hintText: t.carbonation_screen.hint.fermentation_temp,
              suffixText: '°C',
            ),
          ] else ...[
            _NumberField(
              controller: _carbTempCtrl,
              labelText: t.carbonation_screen.labels.carbonation_temp,
              hintText: t.carbonation_screen.hint.carbonation_temp,
              suffixText: '°C',
            ),
          ],
          const SizedBox(height: 24),
          _CarbonationResultCard(
            method: _method,
            target: target,
            volume: volume,
            fermTemp: fermTemp,
            carbTemp: carbTemp,
            sugarResult: sugarResult,
            pressureResult: pressureResult,
          ),
          const SizedBox(height: 16),
          _InfoFooter(text: t.carbonation_screen.info),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Serving pressure (Zapfdruck) calculator
// ---------------------------------------------------------------------------

class _ServingPressureBody extends StatefulWidget {
  const _ServingPressureBody();

  @override
  State<_ServingPressureBody> createState() => _ServingPressureBodyState();
}

class _ServingPressureBodyState extends State<_ServingPressureBody> {
  LineDiameter _diameter = LineDiameter.mm7;
  final TextEditingController _co2Ctrl = TextEditingController(text: '5,0');
  final TextEditingController _tempCtrl = TextEditingController(text: '4');
  final TextEditingController _lengthCtrl = TextEditingController(text: '1,5');
  final TextEditingController _heightCtrl = TextEditingController(text: '0');

  @override
  void initState() {
    super.initState();
    _co2Ctrl.addListener(() => setState(() {}));
    _tempCtrl.addListener(() => setState(() {}));
    _lengthCtrl.addListener(() => setState(() {}));
    _heightCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _co2Ctrl.dispose();
    _tempCtrl.dispose();
    _lengthCtrl.dispose();
    _heightCtrl.dispose();
    super.dispose();
  }

  ServingPressureResult? _compute() {
    final co2 = _parse(_co2Ctrl.text);
    final temp = _parse(_tempCtrl.text);
    final length = _parse(_lengthCtrl.text);
    final height = _parseAllowNegative(_heightCtrl.text);
    if (co2 == null || temp == null || length == null || height == null) {
      return null;
    }
    return ServingPressureCalculation.calculate(
      co2GramsPerLiter: co2,
      beerTempC: temp,
      lineLengthM: length,
      lineDiameter: _diameter,
      heightDifferenceM: height,
    );
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
          _NumberField(
            controller: _co2Ctrl,
            labelText: t.serving_pressure_screen.labels.co2_level,
            hintText: t.serving_pressure_screen.hint.co2,
            suffixText: 'g/L CO₂',
          ),
          const SizedBox(height: 12),
          _NumberField(
            controller: _tempCtrl,
            labelText: t.serving_pressure_screen.labels.beer_temp,
            hintText: t.serving_pressure_screen.hint.beer_temp,
            suffixText: '°C',
          ),
          const SizedBox(height: 16),
          _SectionLabel(text: t.serving_pressure_screen.labels.line_diameter),
          const SizedBox(height: 8),
          SegmentedButton<LineDiameter>(
            showSelectedIcon: false,
            segments: LineDiameter.values
                .map((d) => ButtonSegment(
                      value: d,
                      label: Text(ServingPressureCalculation.diameterLabel(d)),
                    ))
                .toList(),
            selected: {_diameter},
            onSelectionChanged: (s) => setState(() => _diameter = s.first),
          ),
          const SizedBox(height: 16),
          _NumberField(
            controller: _lengthCtrl,
            labelText: t.serving_pressure_screen.labels.line_length,
            hintText: t.serving_pressure_screen.hint.line_length,
            suffixText: 'm',
          ),
          const SizedBox(height: 12),
          _NumberFieldAllowNegative(
            controller: _heightCtrl,
            labelText: t.serving_pressure_screen.labels.height_difference,
            hintText: t.serving_pressure_screen.hint.height_difference,
            suffixText: 'm',
            helperText: t.serving_pressure_screen.height_hint,
          ),
          const SizedBox(height: 24),
          _ServingPressureResultCard(result: result),
          const SizedBox(height: 16),
          _InfoFooter(text: t.serving_pressure_screen.info),
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

class _CarbonationResultCard extends StatelessWidget {
  final CarbonationMethod method;
  final double? target;
  final double? volume;
  final double? fermTemp;
  final double? carbTemp;
  final CarbonationSugarResult? sugarResult;
  final CarbonationPressureResult? pressureResult;

  const _CarbonationResultCard({
    required this.method,
    required this.target,
    required this.volume,
    required this.fermTemp,
    required this.carbTemp,
    required this.sugarResult,
    required this.pressureResult,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final fg = scheme.onPrimaryContainer;

    Widget body;
    switch (method) {
      case CarbonationMethod.bottleSugar:
        if (sugarResult == null || target == null || volume == null || fermTemp == null) {
          body = Text('—', style: TextStyle(color: fg, fontSize: 18));
        } else {
          body = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.carbonation_screen.result.sugar_bottle(
                  sugar: _fmtNumber(sugarResult!.sugarGrams, 1),
                  volume: _fmtNumber(volume!, 1),
                  temp: _fmtNumber(fermTemp!, 1),
                  target: _fmtNumber(target!, 1),
                ),
                style: TextStyle(color: fg, fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 12),
              Text(
                t.carbonation_screen.result.current_co2(
                  co2: _fmtNumber(sugarResult!.residualCo2GramsPerLiter, 1),
                ),
                style: TextStyle(
                  color: fg.withValues(alpha: 0.7),
                  fontSize: 13,
                ),
              ),
            ],
          );
        }
      case CarbonationMethod.kegSugar:
        if (sugarResult == null || target == null || volume == null || fermTemp == null) {
          body = Text('—', style: TextStyle(color: fg, fontSize: 18));
        } else {
          body = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.carbonation_screen.result.sugar_keg(
                  sugar: _fmtNumber(sugarResult!.sugarGrams, 1),
                  volume: _fmtNumber(volume!, 1),
                  temp: _fmtNumber(fermTemp!, 1),
                  target: _fmtNumber(target!, 1),
                ),
                style: TextStyle(color: fg, fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 12),
              Text(
                t.carbonation_screen.result.current_co2(
                  co2: _fmtNumber(sugarResult!.residualCo2GramsPerLiter, 1),
                ),
                style: TextStyle(
                  color: fg.withValues(alpha: 0.7),
                  fontSize: 13,
                ),
              ),
            ],
          );
        }
      case CarbonationMethod.kegForce:
        if (pressureResult == null || target == null || carbTemp == null) {
          body = Text('—', style: TextStyle(color: fg, fontSize: 18));
        } else {
          body = Text(
            t.carbonation_screen.result.force_pressure(
              bar: pressureResult!.bar.toStringAsFixed(2),
              temp: _fmtNumber(carbTemp!, 1),
              target: _fmtNumber(target!, 1),
            ),
            style: TextStyle(color: fg, fontSize: 16, height: 1.4),
          );
        }
    }

    return Card(
      color: scheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: body,
      ),
    );
  }
}

class _ServingPressureResultCard extends StatelessWidget {
  final ServingPressureResult? result;
  const _ServingPressureResultCard({required this.result});

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
              t.serving_pressure_screen.labels.serving_pressure,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: scheme.onPrimaryContainer.withValues(alpha: 0.7),
                  ),
            ),
            const SizedBox(height: 4),
            _BigNumber(
              value: r == null ? '—' : r.totalPressureBar.toStringAsFixed(2),
              unit: 'bar',
            ),
            if (r != null) ...[
              const SizedBox(height: 20),
              _StatRow(
                label: t.serving_pressure_screen.labels.saturation_pressure,
                value: '${r.saturationPressureBar.toStringAsFixed(2)} bar',
              ),
              const SizedBox(height: 8),
              _StatRow(
                label: t.serving_pressure_screen.labels.line_loss,
                value: '${r.lineLossBar.toStringAsFixed(2)} bar',
              ),
              const SizedBox(height: 8),
              _StatRow(
                label: t.serving_pressure_screen.labels.height_loss,
                value: '${r.heightLossBar.toStringAsFixed(2)} bar',
              ),
              const SizedBox(height: 8),
              _StatRow(
                label: t.serving_pressure_screen.labels.safety_margin,
                value: '${r.safetyMarginBar.toStringAsFixed(2)} bar',
              ),
            ],
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

class _NumberFieldAllowNegative extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? suffixText;
  final String? helperText;
  const _NumberFieldAllowNegative({
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.suffixText,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.,-]')),
      ],
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,
        suffixText: suffixText,
        helperText: helperText,
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

/// Like [_parse] but allows negative values (needed for height difference).
double? _parseAllowNegative(String raw) {
  final cleaned = raw.replaceAll(',', '.').trim();
  if (cleaned.isEmpty) return null;
  return double.tryParse(cleaned);
}
