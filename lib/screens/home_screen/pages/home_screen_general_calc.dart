import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mashmaster/calc/general_calc.dart';
import 'package:mashmaster/i18n/generated/translations.g.dart';

class HomeScreenGeneralCalc extends StatefulWidget {
  const HomeScreenGeneralCalc({super.key});

  @override
  State<HomeScreenGeneralCalc> createState() => _HomeScreenGeneralCalcState();
}

class _HomeScreenGeneralCalcState extends State<HomeScreenGeneralCalc> {
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

  double? _parse(String raw) {
    final cleaned = raw.replaceAll(',', '.').trim();
    if (cleaned.isEmpty) return null;
    final v = double.tryParse(cleaned);
    if (v == null || v < 0) return null;
    return v;
  }

  String _ogHint(Translations t) => _unit == GravityUnit.plato
      ? t.general_screen.hint.og_plato
      : t.general_screen.hint.og_sg;

  String _fgHint(Translations t) => _unit == GravityUnit.plato
      ? t.general_screen.hint.fg_plato
      : t.general_screen.hint.fg_sg;

  String _unitSuffix(Translations t) => _unit == GravityUnit.plato
      ? t.general_screen.units.plato
      : t.general_screen.units.sg;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final og = _parse(_ogCtrl.text);
    final fg = _parse(_fgCtrl.text);
    final stats = (og == null || fg == null)
        ? null
        : GeneralCalculation.fromGravities(og: og, fg: fg, unit: _unit);

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
          TextField(
            controller: _ogCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
            ],
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: t.general_screen.labels.og,
              hintText: _ogHint(t),
              suffixText: _unitSuffix(t),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _fgCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
            ],
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: t.general_screen.labels.fg,
              hintText: _fgHint(t),
              suffixText: _unitSuffix(t),
            ),
          ),
          const SizedBox(height: 24),
          _ResultCard(stats: stats),
          const SizedBox(height: 16),
          _InfoFooter(text: t.general_screen.info),
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

class _ResultCard extends StatelessWidget {
  final BrewStats? stats;
  const _ResultCard({required this.stats});

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
            // Headline: ABV
            Text(
              t.general_screen.labels.abv,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: scheme.onPrimaryContainer.withValues(alpha: 0.7),
                  ),
            ),
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: scheme.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                children: [
                  TextSpan(text: s == null ? '—' : _fmtPercent(s.abv)),
                  TextSpan(
                    text: ' %',
                    style: TextStyle(
                      fontSize: 22,
                      color: scheme.onPrimaryContainer.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ABW
            _StatRow(
              label: t.general_screen.labels.abw,
              value: s == null ? '—' : '${_fmtPercent(s.abw)} %',
            ),
            const SizedBox(height: 16),

            // Calories + carbs (per 100ml)
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

            // Attenuations
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

            // Extracts (always shown in °Plato)
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
