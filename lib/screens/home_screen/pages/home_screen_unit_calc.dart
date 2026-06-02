import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mashmaster/calc/unit_calc.dart';
import 'package:mashmaster/i18n/generated/translations.g.dart';

class HomeScreenUnitCalc extends StatelessWidget {
  const HomeScreenUnitCalc({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: 3,
      initialIndex: 1, // Start with Weight tab open
      child: Column(
        children: [
          Material(
            color: scheme.surface,
            child: TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              tabs: [
                Tab(text: t.unit_screen.tabs.volume),
                Tab(text: t.unit_screen.tabs.weight),
                Tab(text: t.unit_screen.tabs.temperature),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                _PlaceholderBody(),
                _WeightBody(),
                _PlaceholderBody(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceholderBody extends StatelessWidget {
  const _PlaceholderBody();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        t.generic.placeholder_label,
        style: const TextStyle(height: 1.5, fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _WeightBody extends StatefulWidget {
  const _WeightBody();

  @override
  State<_WeightBody> createState() => _WeightBodyState();
}

class _WeightBodyState extends State<_WeightBody> {
  final TextEditingController _kgCtrl = TextEditingController();
  final TextEditingController _gCtrl = TextEditingController();
  final TextEditingController _lbsCtrl = TextEditingController();
  final TextEditingController _ozCtrl = TextEditingController();
  final TextEditingController _stCtrl = TextEditingController();

  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _kgCtrl.addListener(() => _updateFrom(_kgCtrl, 'kg'));
    _gCtrl.addListener(() => _updateFrom(_gCtrl, 'g'));
    _lbsCtrl.addListener(() => _updateFrom(_lbsCtrl, 'lbs'));
    _ozCtrl.addListener(() => _updateFrom(_ozCtrl, 'oz'));
    _stCtrl.addListener(() => _updateFrom(_stCtrl, 'st'));
  }

  @override
  void dispose() {
    _kgCtrl.dispose();
    _gCtrl.dispose();
    _lbsCtrl.dispose();
    _ozCtrl.dispose();
    _stCtrl.dispose();
    super.dispose();
  }

  double? _parse(String raw) {
    final cleaned = raw.replaceAll(',', '.').trim();
    if (cleaned.isEmpty || cleaned == '.' || cleaned == '-') return null;
    return double.tryParse(cleaned);
  }

  String _format(double v) {
    if (v == 0) return '0';
    String s = v.toStringAsFixed(4);
    s = s.replaceAll(RegExp(r'0*$'), '');
    if (s.endsWith('.')) {
      s = s.substring(0, s.length - 1);
    }
    return s.replaceAll('.', ',');
  }

  void _updateFrom(TextEditingController sourceCtrl, String unit) {
    if (_isUpdating) return;

    final val = _parse(sourceCtrl.text);

    if (val == null) {
      _isUpdating = true;
      if (unit != 'kg') _kgCtrl.clear();
      if (unit != 'g') _gCtrl.clear();
      if (unit != 'lbs') _lbsCtrl.clear();
      if (unit != 'oz') _ozCtrl.clear();
      if (unit != 'st') _stCtrl.clear();
      _isUpdating = false;
      return;
    }

    double grams = 0;
    switch (unit) {
      case 'kg':
        grams = WeightUnitCalc.kgToGrams(val);
        break;
      case 'g':
        grams = val;
        break;
      case 'lbs':
        grams = WeightUnitCalc.lbsToGrams(val);
        break;
      case 'oz':
        grams = WeightUnitCalc.ozToGrams(val);
        break;
      case 'st':
        grams = WeightUnitCalc.stToGrams(val);
        break;
    }

    _isUpdating = true;
    if (unit != 'kg') _kgCtrl.text = _format(WeightUnitCalc.gramsToKg(grams));
    if (unit != 'g') _gCtrl.text = _format(grams);
    if (unit != 'lbs') _lbsCtrl.text = _format(WeightUnitCalc.gramsToLbs(grams));
    if (unit != 'oz') _ozCtrl.text = _format(WeightUnitCalc.gramsToOz(grams));
    if (unit != 'st') _stCtrl.text = _format(WeightUnitCalc.gramsToSt(grams));
    _isUpdating = false;
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionLabel(text: t.unit_screen.sections.metric),
          const SizedBox(height: 8),
          _NumberField(
            controller: _kgCtrl,
            labelText: t.unit_screen.weight_units.kilograms,
            hintText: '0',
            suffixText: 'kg',
          ),
          const SizedBox(height: 12),
          _NumberField(
            controller: _gCtrl,
            labelText: t.unit_screen.weight_units.grams,
            hintText: '0',
            suffixText: 'g',
          ),
          const SizedBox(height: 24),
          _SectionLabel(text: t.unit_screen.sections.us),
          const SizedBox(height: 8),
          _NumberField(
            controller: _lbsCtrl,
            labelText: t.unit_screen.weight_units.pounds,
            hintText: '0',
            suffixText: 'lb',
          ),
          const SizedBox(height: 12),
          _NumberField(
            controller: _ozCtrl,
            labelText: t.unit_screen.weight_units.ounces,
            hintText: '0',
            suffixText: 'oz',
          ),
          const SizedBox(height: 24),
          _SectionLabel(text: t.unit_screen.sections.imperial),
          const SizedBox(height: 8),
          _NumberField(
            controller: _stCtrl,
            labelText: t.unit_screen.weight_units.stones,
            hintText: '0',
            suffixText: 'st',
          ),
          const SizedBox(height: 24),
          _InfoFooter(text: t.unit_screen.info),
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
