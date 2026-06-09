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
          // ── Tab bar with right-edge fade to hint scrollability ─────────
          Material(
            color: scheme.surface,
            child: _FadingTabBar(
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

// ─────────────────────────────────────────────────────────────────────────────
// Tab bar with a right-edge fade indicating scrollability
// ─────────────────────────────────────────────────────────────────────────────

class _FadingTabBar extends StatelessWidget {
  final List<Widget> tabs;
  const _FadingTabBar({required this.tabs});

  @override
  Widget build(BuildContext context) {
    final surfaceColor = Theme.of(context).colorScheme.surface;
    return ShaderMask(
      shaderCallback: (rect) => LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: const [0.0, 0.75, 1.0],
        colors: [
          surfaceColor.withValues(alpha: 0.0),
          surfaceColor.withValues(alpha: 0.0),
          surfaceColor,
        ],
      ).createShader(rect),
      blendMode: BlendMode.dstOut,
      child: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        tabs: tabs,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared form-grouping container (same pattern as dosage calculator)
// ─────────────────────────────────────────────────────────────────────────────

class _FormCard extends StatelessWidget {
  final String? label;
  final Widget child;

  const _FormCard({this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: scheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      padding: EdgeInsets.fromLTRB(16, label != null ? 12 : 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null) ...[
            _SectionLabel(text: label!),
            const SizedBox(height: 12),
          ],
          child,
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Stepper field: − | TextField | +
// ─────────────────────────────────────────────────────────────────────────────

class _StepperField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? suffixText;
  final double step;
  final double min;
  final bool allowNegative;
  final String? helperText;

  const _StepperField({
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.suffixText,
    this.step = 1.0,
    this.min = 0.0,
    this.allowNegative = false,
    this.helperText,
  });

  double? _parse() {
    final cleaned = controller.text.replaceAll(',', '.').trim();
    if (cleaned.isEmpty || cleaned == '.' || cleaned == '-') return null;
    return double.tryParse(cleaned);
  }

  String _format(double v) {
    // Show enough decimals to represent the step cleanly
    if (step < 0.01) return v.toStringAsFixed(3).replaceAll('.', ',');
    if (step < 0.1) return v.toStringAsFixed(2).replaceAll('.', ',');
    if (step < 1.0) return v.toStringAsFixed(1).replaceAll('.', ',');
    return v.toStringAsFixed(0).replaceAll('.', ',');
  }

  void _step(double delta) {
    final current = _parse() ?? 0.0;
    final next = allowNegative
        ? current + delta
        : (current + delta).clamp(min, double.infinity);
    controller.text = _format(next);
    // Move cursor to end
    controller.selection = TextSelection.collapsed(
      offset: controller.text.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StepButton(
          icon: Icons.remove,
          onPressed: () => _step(-step),
          color: scheme.surfaceContainerHigh,
          iconColor: scheme.onSurface,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.numberWithOptions(
              decimal: true,
              signed: allowNegative,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                allowNegative ? RegExp(r'[0-9.,-]') : RegExp(r'[0-9.,]'),
              ),
            ],
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: labelText,
              hintText: hintText,
              suffixText: suffixText,
              helperText: helperText,
              isDense: true,
            ),
          ),
        ),
        const SizedBox(width: 8),
        _StepButton(
          icon: Icons.add,
          onPressed: () => _step(step),
          color: scheme.surfaceContainerHigh,
          iconColor: scheme.onSurface,
        ),
      ],
    );
  }
}

class _StepButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;
  final Color iconColor;

  const _StepButton({
    required this.icon,
    required this.onPressed,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(icon, size: 20, color: iconColor),
        ),
      ),
    );
  }
}



// ─────────────────────────────────────────────────────────────────────────────
// Pinned result card shell
// ─────────────────────────────────────────────────────────────────────────────

/// Wraps any result content in the elevated, top-rounded pinned bar style.
class _PinnedCard extends StatelessWidget {
  final Widget child;
  const _PinnedCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: child,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ABV / Calorie calculator
// ─────────────────────────────────────────────────────────────────────────────

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

    // Step size depends on the unit
    final step = _unit == GravityUnit.plato ? 0.1 : 0.001;

    return Column(
      children: [
        // ── Scrollable inputs ──────────────────────────────────────────────
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Unit selector
                _FormCard(
                  label: t.general_screen.section.input,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                        onSelectionChanged: (s) =>
                            setState(() => _unit = s.first),
                      ),
                      const SizedBox(height: 16),
                      _StepperField(
                        controller: _ogCtrl,
                        labelText: t.general_screen.labels.og,
                        hintText: _unit == GravityUnit.plato
                            ? t.general_screen.hint.og_plato
                            : t.general_screen.hint.og_sg,
                        suffixText: unitSuffix,
                        step: step,
                        min: 0,
                      ),
                      const SizedBox(height: 12),
                      _StepperField(
                        controller: _fgCtrl,
                        labelText: t.general_screen.labels.fg,
                        hintText: _unit == GravityUnit.plato
                            ? t.general_screen.hint.fg_plato
                            : t.general_screen.hint.fg_sg,
                        suffixText: unitSuffix,
                        step: step,
                        min: 0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _InfoFooter(text: t.general_screen.info),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        // ── Pinned result ──────────────────────────────────────────────────
        _PinnedCard(child: _AbvResultCardContent(stats: stats)),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Refractometer calculator
// ─────────────────────────────────────────────────────────────────────────────

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

    return Column(
      children: [
        // ── Scrollable inputs ──────────────────────────────────────────────
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _FormCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CheckboxListTile(
                        value: _fermented,
                        onChanged: (v) =>
                            setState(() => _fermented = v ?? false),
                        title: Text(t.refractometer_screen.fermented_wort),
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      if (_fermented) ...[
                        const SizedBox(height: 8),
                        _StepperField(
                          controller: _ogCtrl,
                          labelText: t.refractometer_screen.labels.og,
                          hintText: t.refractometer_screen.hint.og,
                          suffixText: '°P',
                          step: 0.1,
                        ),
                        const SizedBox(height: 12),
                      ],
                      _StepperField(
                        controller: _brixCtrl,
                        labelText: t.refractometer_screen.labels.brix,
                        hintText: t.refractometer_screen.hint.brix,
                        step: 0.1,
                      ),
                      const SizedBox(height: 12),
                      _StepperField(
                        controller: _cfCtrl,
                        labelText:
                            t.refractometer_screen.labels.correction_factor,
                        hintText:
                            t.refractometer_screen.hint.correction_factor,
                        step: 0.01,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _InfoFooter(text: t.refractometer_screen.info),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        // ── Pinned result ──────────────────────────────────────────────────
        _PinnedCard(
          child: _RefractometerResultContent(
            result: result,
            fermented: _fermented,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Hydrometer temperature correction
// ─────────────────────────────────────────────────────────────────────────────

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
    final gravityStep = _unit == GravityUnit.plato ? 0.1 : 0.001;

    return Column(
      children: [
        // ── Scrollable inputs ──────────────────────────────────────────────
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _FormCard(
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
                        onSelectionChanged: (s) =>
                            setState(() => _unit = s.first),
                      ),
                      const SizedBox(height: 16),
                      _StepperField(
                        controller: _measuredCtrl,
                        labelText: t.hydrometer_screen.labels.measured_gravity,
                        hintText: measuredHint,
                        suffixText: unitSuffix,
                        step: gravityStep,
                      ),
                      const SizedBox(height: 12),
                      _StepperField(
                        controller: _wortTempCtrl,
                        labelText: t.hydrometer_screen.labels.temperature,
                        hintText: t.hydrometer_screen.hint.temperature,
                        suffixText: '°C',
                        step: 1,
                      ),
                      const SizedBox(height: 12),
                      _StepperField(
                        controller: _calibrationTempCtrl,
                        labelText: t.hydrometer_screen.labels.calibration_temp,
                        hintText: t.hydrometer_screen.hint.calibration_temp,
                        suffixText: '°C',
                        step: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _InfoFooter(text: t.hydrometer_screen.info),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        // ── Pinned result ──────────────────────────────────────────────────
        _PinnedCard(
          child: _HydrometerResultContent(corrected: corrected, unit: _unit),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Carbonation calculator
// ─────────────────────────────────────────────────────────────────────────────

class _CarbonationBody extends StatefulWidget {
  const _CarbonationBody();

  @override
  State<_CarbonationBody> createState() => _CarbonationBodyState();
}

class _CarbonationBodyState extends State<_CarbonationBody> {
  BeerStyle _style = beerStyles.first;
  CarbonationMethod _method = CarbonationMethod.bottleSugar;

  late final TextEditingController _targetCo2Ctrl;
  final TextEditingController _volumeCtrl =
      TextEditingController(text: '20');
  final TextEditingController _fermTempCtrl =
      TextEditingController(text: '20');
  final TextEditingController _carbTempCtrl =
      TextEditingController(text: '4');

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

    return Column(
      children: [
        // ── Scrollable inputs ──────────────────────────────────────────────
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Block 1: Beer style + target CO₂
                _FormCard(
                  label: t.carbonation_screen.labels.beer_style,
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
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          '${t.carbonation_screen.labels.style_range}: '
                          '${_formatGpl(_style.minCo2GramsPerLiter)} – '
                          '${_formatGpl(_style.maxCo2GramsPerLiter)} g/L',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _StepperField(
                        controller: _targetCo2Ctrl,
                        labelText: t.carbonation_screen.labels.target_co2,
                        hintText: _formatGpl(_style.minCo2GramsPerLiter),
                        suffixText: 'g/L CO₂',
                        step: 0.1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // Block 2: Method
                _FormCard(
                  label: t.carbonation_screen.labels.method,
                  child: SegmentedButton<CarbonationMethod>(
                    showSelectedIcon: false,
                    segments: [
                      ButtonSegment(
                        value: CarbonationMethod.bottleSugar,
                        label: Text(
                            t.carbonation_screen.methods.bottle_sugar),
                      ),
                      ButtonSegment(
                        value: CarbonationMethod.kegSugar,
                        label:
                            Text(t.carbonation_screen.methods.keg_sugar),
                      ),
                      ButtonSegment(
                        value: CarbonationMethod.kegForce,
                        label:
                            Text(t.carbonation_screen.methods.keg_force),
                      ),
                    ],
                    selected: {_method},
                    onSelectionChanged: (s) =>
                        setState(() => _method = s.first),
                  ),
                ),
                const SizedBox(height: 12),
                // Block 3: Method-specific inputs
                if (isSugar)
                  _FormCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _StepperField(
                          controller: _volumeCtrl,
                          labelText: volumeLabel,
                          hintText: t.carbonation_screen.hint.volume,
                          suffixText: 'L',
                          step: 1,
                        ),
                        const SizedBox(height: 12),
                        _StepperField(
                          controller: _fermTempCtrl,
                          labelText: t.carbonation_screen.labels
                              .peak_fermentation_temp,
                          hintText:
                              t.carbonation_screen.hint.fermentation_temp,
                          suffixText: '°C',
                          step: 1,
                        ),
                      ],
                    ),
                  )
                else
                  _FormCard(
                    child: _StepperField(
                      controller: _carbTempCtrl,
                      labelText:
                          t.carbonation_screen.labels.carbonation_temp,
                      hintText: t.carbonation_screen.hint.carbonation_temp,
                      suffixText: '°C',
                      step: 1,
                    ),
                  ),
                const SizedBox(height: 12),
                _InfoFooter(text: t.carbonation_screen.info),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        // ── Pinned result ──────────────────────────────────────────────────
        _PinnedCard(
          child: _CarbonationResultContent(
            method: _method,
            target: target,
            volume: volume,
            fermTemp: fermTemp,
            carbTemp: carbTemp,
            sugarResult: sugarResult,
            pressureResult: pressureResult,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Serving pressure (Zapfdruck) calculator
// ─────────────────────────────────────────────────────────────────────────────

class _ServingPressureBody extends StatefulWidget {
  const _ServingPressureBody();

  @override
  State<_ServingPressureBody> createState() => _ServingPressureBodyState();
}

class _ServingPressureBodyState extends State<_ServingPressureBody> {
  LineDiameter _diameter = LineDiameter.mm7;
  final TextEditingController _co2Ctrl =
      TextEditingController(text: '5,0');
  final TextEditingController _tempCtrl =
      TextEditingController(text: '4');
  final TextEditingController _lengthCtrl =
      TextEditingController(text: '1,5');
  final TextEditingController _heightCtrl =
      TextEditingController(text: '0');

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

    return Column(
      children: [
        // ── Scrollable inputs ──────────────────────────────────────────────
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Block 1: Beer conditions
                _FormCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _StepperField(
                        controller: _co2Ctrl,
                        labelText:
                            t.serving_pressure_screen.labels.co2_level,
                        hintText: t.serving_pressure_screen.hint.co2,
                        suffixText: 'g/L CO₂',
                        step: 0.1,
                      ),
                      const SizedBox(height: 12),
                      _StepperField(
                        controller: _tempCtrl,
                        labelText:
                            t.serving_pressure_screen.labels.beer_temp,
                        hintText: t.serving_pressure_screen.hint.beer_temp,
                        suffixText: '°C',
                        step: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // Block 2: Line setup
                _FormCard(
                  label: t.serving_pressure_screen.labels.line_diameter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SegmentedButton<LineDiameter>(
                        showSelectedIcon: false,
                        segments: LineDiameter.values
                            .map((d) => ButtonSegment(
                                  value: d,
                                  label: Text(
                                      ServingPressureCalculation.diameterLabel(
                                          d)),
                                ))
                            .toList(),
                        selected: {_diameter},
                        onSelectionChanged: (s) =>
                            setState(() => _diameter = s.first),
                      ),
                      const SizedBox(height: 16),
                      _StepperField(
                        controller: _lengthCtrl,
                        labelText:
                            t.serving_pressure_screen.labels.line_length,
                        hintText:
                            t.serving_pressure_screen.hint.line_length,
                        suffixText: 'm',
                        step: 0.5,
                      ),
                      const SizedBox(height: 12),
                      _StepperField(
                        controller: _heightCtrl,
                        labelText:
                            t.serving_pressure_screen.labels.height_difference,
                        hintText:
                            t.serving_pressure_screen.hint.height_difference,
                        suffixText: 'm',
                        step: 0.1,
                        allowNegative: true,
                        helperText:
                            t.serving_pressure_screen.height_hint,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _InfoFooter(text: t.serving_pressure_screen.info),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        // ── Pinned result ──────────────────────────────────────────────────
        _PinnedCard(
          child: _ServingPressureResultContent(result: result),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Result card contents (inline, styled for the pinned card background)
// ─────────────────────────────────────────────────────────────────────────────

class _AbvResultCardContent extends StatelessWidget {
  final BrewStats? stats;
  const _AbvResultCardContent({required this.stats});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final s = stats;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          t.general_screen.labels.abv,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: scheme.onPrimaryContainer.withValues(alpha: 0.65),
              ),
        ),
        const SizedBox(height: 2),
        _BigNumber(
          value: s == null ? '—' : _fmtPercent(s.abv),
          unit: '%',
        ),
        if (s != null) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 20,
            runSpacing: 6,
            children: [
              _StatRow(
                label: t.general_screen.labels.abw,
                value: '${_fmtPercent(s.abw)} %',
              ),
              _StatRow(
                label: t.general_screen.labels.calories,
                value:
                    '${_fmtNumber(s.kcalPer100ml, 1)} kcal · ${_fmtNumber(s.kjPer100ml, 1)} kJ',
                suffix: t.general_screen.per_100ml,
              ),
              _StatRow(
                label: t.general_screen.labels.carbs,
                value: '${_fmtNumber(s.carbsPer100ml, 1)} g',
                suffix: t.general_screen.per_100ml,
              ),
              _StatRow(
                label: t.general_screen.labels.apparent_attenuation,
                value: '${_fmtPercent(s.apparentAttenuation)} %',
              ),
              _StatRow(
                label: t.general_screen.labels.real_attenuation,
                value: '${_fmtPercent(s.realAttenuation)} %',
              ),
              _StatRow(
                label: t.general_screen.labels.original_extract,
                value: '${_fmtNumber(s.originalExtractPlato, 2)} °P',
              ),
              _StatRow(
                label: t.general_screen.labels.apparent_extract,
                value: '${_fmtNumber(s.apparentExtractPlato, 2)} °P',
              ),
              _StatRow(
                label: t.general_screen.labels.real_extract,
                value: '${_fmtNumber(s.realExtractPlato, 2)} °P',
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _RefractometerResultContent extends StatelessWidget {
  final RefractometerResult? result;
  final bool fermented;
  const _RefractometerResultContent(
      {required this.result, required this.fermented});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final r = result;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          t.refractometer_screen.labels.gravity,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: scheme.onPrimaryContainer.withValues(alpha: 0.65),
              ),
        ),
        const SizedBox(height: 2),
        _BigNumber(
          value: r == null ? '—' : _fmtNumber(r.gravityPlato, 1),
          unit: '°P',
        ),
        if (fermented && r != null && r.abv != null) ...[
          const SizedBox(height: 8),
          Text(
            '${t.refractometer_screen.labels.abv} ${_fmtPercent(r.abv!)}% · '
            '${t.refractometer_screen.labels.abw} ${_fmtPercent(r.abw!)}%',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      scheme.onPrimaryContainer.withValues(alpha: 0.75),
                ),
          ),
        ],
      ],
    );
  }
}

class _HydrometerResultContent extends StatelessWidget {
  final double? corrected;
  final GravityUnit unit;
  const _HydrometerResultContent(
      {required this.corrected, required this.unit});

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          t.hydrometer_screen.labels.corrected_gravity,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: scheme.onPrimaryContainer.withValues(alpha: 0.65),
              ),
        ),
        const SizedBox(height: 2),
        _BigNumber(value: value, unit: unitLabel),
      ],
    );
  }
}

class _CarbonationResultContent extends StatelessWidget {
  final CarbonationMethod method;
  final double? target;
  final double? volume;
  final double? fermTemp;
  final double? carbTemp;
  final CarbonationSugarResult? sugarResult;
  final CarbonationPressureResult? pressureResult;

  const _CarbonationResultContent({
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
        if (sugarResult == null ||
            target == null ||
            volume == null ||
            fermTemp == null) {
          body = Text('—', style: TextStyle(color: fg, fontSize: 18));
        } else {
          body = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                t.carbonation_screen.result.sugar_bottle(
                  sugar: _fmtNumber(sugarResult!.sugarGrams, 1),
                  volume: _fmtNumber(volume!, 1),
                  temp: _fmtNumber(fermTemp!, 1),
                  target: _fmtNumber(target!, 1),
                ),
                style:
                    TextStyle(color: fg, fontSize: 15, height: 1.4),
              ),
              const SizedBox(height: 8),
              Text(
                t.carbonation_screen.result.current_co2(
                  co2: _fmtNumber(
                      sugarResult!.residualCo2GramsPerLiter, 1),
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
        if (sugarResult == null ||
            target == null ||
            volume == null ||
            fermTemp == null) {
          body = Text('—', style: TextStyle(color: fg, fontSize: 18));
        } else {
          body = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                t.carbonation_screen.result.sugar_keg(
                  sugar: _fmtNumber(sugarResult!.sugarGrams, 1),
                  volume: _fmtNumber(volume!, 1),
                  temp: _fmtNumber(fermTemp!, 1),
                  target: _fmtNumber(target!, 1),
                ),
                style:
                    TextStyle(color: fg, fontSize: 15, height: 1.4),
              ),
              const SizedBox(height: 8),
              Text(
                t.carbonation_screen.result.current_co2(
                  co2: _fmtNumber(
                      sugarResult!.residualCo2GramsPerLiter, 1),
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
        if (pressureResult == null ||
            target == null ||
            carbTemp == null) {
          body = Text('—', style: TextStyle(color: fg, fontSize: 18));
        } else {
          body = Text(
            t.carbonation_screen.result.force_pressure(
              bar: pressureResult!.bar.toStringAsFixed(2),
              temp: _fmtNumber(carbTemp!, 1),
              target: _fmtNumber(target!, 1),
            ),
            style: TextStyle(color: fg, fontSize: 15, height: 1.4),
          );
        }
    }

    return body;
  }
}

class _ServingPressureResultContent extends StatelessWidget {
  final ServingPressureResult? result;
  const _ServingPressureResultContent({required this.result});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final r = result;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          t.serving_pressure_screen.labels.serving_pressure,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: scheme.onPrimaryContainer.withValues(alpha: 0.65),
              ),
        ),
        const SizedBox(height: 2),
        _BigNumber(
          value:
              r == null ? '—' : r.totalPressureBar.toStringAsFixed(2),
          unit: 'bar',
        ),
        if (r != null) ...[
          const SizedBox(height: 10),
          Wrap(
            spacing: 20,
            runSpacing: 4,
            children: [
              _StatRow(
                label:
                    t.serving_pressure_screen.labels.saturation_pressure,
                value: '${r.saturationPressureBar.toStringAsFixed(2)} bar',
              ),
              _StatRow(
                label: t.serving_pressure_screen.labels.line_loss,
                value: '${r.lineLossBar.toStringAsFixed(2)} bar',
              ),
              _StatRow(
                label: t.serving_pressure_screen.labels.height_loss,
                value: '${r.heightLossBar.toStringAsFixed(2)} bar',
              ),
              _StatRow(
                label: t.serving_pressure_screen.labels.safety_margin,
                value: '${r.safetyMarginBar.toStringAsFixed(2)} bar',
              ),
            ],
          ),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared display widgets
// ─────────────────────────────────────────────────────────────────────────────

class _BigNumber extends StatelessWidget {
  final String value;
  final String unit;
  const _BigNumber({required this.value, required this.unit});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: scheme.onPrimaryContainer,
              fontWeight: FontWeight.w700,
            ),
        children: [
          TextSpan(text: value),
          TextSpan(
            text: ' $unit',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: scheme.onPrimaryContainer.withValues(alpha: 0.65),
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
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '$label ',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: labelColor,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: scheme.onPrimaryContainer,
                fontWeight: FontWeight.w600,
              ),
        ),
        if (suffix != null) ...[
          const SizedBox(width: 4),
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
        Icon(Icons.info_outline, size: 16, color: color),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style:
                Theme.of(context).textTheme.bodySmall?.copyWith(color: color),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared parsing helpers (file-level, same as before)
// ─────────────────────────────────────────────────────────────────────────────

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
