import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mashmaster/calc/dosagecalc.dart';
import 'package:mashmaster/i18n/generated/translations.g.dart';

class HomeScreenDosageCalc extends StatefulWidget {
  const HomeScreenDosageCalc({super.key});

  @override
  State<HomeScreenDosageCalc> createState() => _HomeScreenDosageCalcState();
}

class _HomeScreenDosageCalcState extends State<HomeScreenDosageCalc> {
  DosageType _product = DosageType.starSan;
  PbwMode _pbwMode = PbwMode.coldSide;
  DosageUnit _customUnit = DosageUnit.milliliter;
  final TextEditingController _waterCtrl = TextEditingController(text: '20');
  final TextEditingController _customFactorCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _waterCtrl.addListener(() => setState(() {}));
    _customFactorCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _waterCtrl.dispose();
    _customFactorCtrl.dispose();
    super.dispose();
  }

  double? _parseNumber(String raw) {
    final cleaned = raw.replaceAll(',', '.').trim();
    if (cleaned.isEmpty) return null;
    final v = double.tryParse(cleaned);
    if (v == null || v <= 0) return null;
    return v;
  }

  DosageCalculation? _buildCalculation() {
    if (_product == DosageType.custom) {
      final factor = _parseNumber(_customFactorCtrl.text);
      if (factor == null) return null;
      return DosageCalculation(
        type: DosageType.custom,
        customFactor: factor,
        customUnit: _customUnit,
      );
    }
    return DosageCalculation(type: _product, pbwMode: _pbwMode);
  }

  String _productLabel(Translations t, DosageType type) {
    switch (type) {
      case DosageType.starSan:
        return 'StarSan';
      case DosageType.saniClean:
        return 'SaniClean';
      case DosageType.pbw:
        return 'PBW';
      case DosageType.chemiproOxi:
        return 'ChemiPro Oxi';
      case DosageType.enzyBrew:
        return 'EnzyBrew';
      case DosageType.custom:
        return t.dosage_screen.products.custom;
    }
  }

  String _contactTimeLabel(Translations t, DosageType type) {
    switch (type) {
      case DosageType.starSan:
        return t.dosage_screen.contact_time.starsan;
      case DosageType.saniClean:
        return t.dosage_screen.contact_time.saniclean;
      case DosageType.pbw:
        return t.dosage_screen.contact_time.pbw;
      case DosageType.chemiproOxi:
        return t.dosage_screen.contact_time.chemipro_oxi;
      case DosageType.enzyBrew:
        return t.dosage_screen.contact_time.enzybrew;
      case DosageType.custom:
        return t.dosage_screen.contact_time.custom;
    }
  }

  String _unitLabel(DosageUnit unit) {
    switch (unit) {
      case DosageUnit.milliliter:
        return 'ml';
      case DosageUnit.gram:
        return 'g';
    }
  }

  /// Increment or decrement the water value by [delta] litres.
  void _stepWater(double delta) {
    final current = _parseNumber(_waterCtrl.text) ?? 0;
    final next = (current + delta).clamp(0, double.infinity);
    // Format: no decimal if whole number
    _waterCtrl.text = next == next.roundToDouble()
        ? next.toStringAsFixed(0)
        : next.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final liters = _parseNumber(_waterCtrl.text);
    final calc = _buildCalculation();
    final amount = (liters == null || calc == null) ? null : calc.amountFor(liters);

    return Stack(
      children: [
        // ── Scrollable input area ──────────────────────────────────────────
        Positioned.fill(
          child: SingleChildScrollView(
            // Bottom padding reserves space for the pinned result card.
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 180),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Product Selection Card ─────────────────────────────────
                _FormCard(
                  label: t.dosage_screen.section.product,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: DosageType.values.map((type) {
                          return ChoiceChip(
                            label: Text(_productLabel(t, type)),
                            selected: _product == type,
                            onSelected: (_) =>
                                setState(() => _product = type),
                          );
                        }).toList(),
                      ),
                      if (_product == DosageType.pbw) ...[
                        const SizedBox(height: 16),
                        _SectionLabel(
                            text: t.dosage_screen.section.application),
                        const SizedBox(height: 8),
                        SegmentedButton<PbwMode>(
                          segments: [
                            ButtonSegment(
                              value: PbwMode.coldSide,
                              label: Text(t.dosage_screen.pbw_mode.cold),
                            ),
                            ButtonSegment(
                              value: PbwMode.hotSide,
                              label: Text(t.dosage_screen.pbw_mode.hot),
                            ),
                          ],
                          selected: {_pbwMode},
                          onSelectionChanged: (s) =>
                              setState(() => _pbwMode = s.first),
                        ),
                      ],
                      if (_product == DosageType.custom) ...[
                        const SizedBox(height: 16),
                        _SectionLabel(
                            text: t.dosage_screen.custom.factor_label),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _customFactorCtrl,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9.,]')),
                                ],
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText:
                                      t.dosage_screen.custom.factor_hint,
                                  suffixText: '/L',
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            SegmentedButton<DosageUnit>(
                              segments: const [
                                ButtonSegment(
                                  value: DosageUnit.milliliter,
                                  label: Text('ml'),
                                ),
                                ButtonSegment(
                                  value: DosageUnit.gram,
                                  label: Text('g'),
                                ),
                              ],
                              selected: {_customUnit},
                              onSelectionChanged: (s) =>
                                  setState(() => _customUnit = s.first),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // ── Water Input Card ───────────────────────────────────────
                _FormCard(
                  label: t.dosage_screen.section.water,
                  child: Row(
                    children: [
                      // Minus button
                      _StepButton(
                        icon: Icons.remove,
                        onPressed: () => _stepWater(-1),
                      ),
                      const SizedBox(width: 12),
                      // Text field
                      Expanded(
                        child: TextField(
                          controller: _waterCtrl,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.,]')),
                          ],
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            suffixText: 'L',
                            hintText: t.dosage_screen.water_hint,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Plus button
                      _StepButton(
                        icon: Icons.add,
                        onPressed: () => _stepWater(1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // ── Pinned Result Card ─────────────────────────────────────────────
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _PinnedResultCard(
            productLabel: _productLabel(t, _product),
            amount: amount,
            unit: calc == null ? _customUnit : calc.unit,
            noRinse: calc?.noRinse ?? true,
            contactTime: _contactTimeLabel(t, _product),
            showMeta: _product != DosageType.custom,
            unitLabel: _unitLabel,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Form Card wrapper
// ─────────────────────────────────────────────────────────────────────────────

class _FormCard extends StatelessWidget {
  final String label;
  final Widget child;
  const _FormCard({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionLabel(text: label),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Stepper button (+/−)
// ─────────────────────────────────────────────────────────────────────────────

class _StepButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const _StepButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(icon, size: 22, color: scheme.onSurface),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section label (shared inside this file)
// ─────────────────────────────────────────────────────────────────────────────

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

// ─────────────────────────────────────────────────────────────────────────────
// Pinned Result Card (replaces the old scrollable _ResultCard)
// ─────────────────────────────────────────────────────────────────────────────

class _PinnedResultCard extends StatelessWidget {
  final String productLabel;
  final double? amount;
  final DosageUnit unit;
  final bool noRinse;
  final String contactTime;
  final bool showMeta;
  final String Function(DosageUnit) unitLabel;

  const _PinnedResultCard({
    required this.productLabel,
    required this.amount,
    required this.unit,
    required this.noRinse,
    required this.contactTime,
    required this.showMeta,
    required this.unitLabel,
  });

  String _format(double v) {
    if (v >= 100) return v.toStringAsFixed(0);
    if (v >= 10) return v.toStringAsFixed(1);
    return v.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final hasResult = amount != null;

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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Amount + unit
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      t.dosage_screen.result.label,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: scheme.onPrimaryContainer
                                .withValues(alpha: 0.65),
                          ),
                    ),
                    const SizedBox(height: 2),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                          color: scheme.onPrimaryContainer,
                          fontWeight: FontWeight.w700,
                        ),
                        children: [
                          TextSpan(
                              text: hasResult ? _format(amount!) : '—'),
                          TextSpan(
                            text: ' ${unitLabel(unit)}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: scheme.onPrimaryContainer
                                  .withValues(alpha: 0.65),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      productLabel,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: scheme.onPrimaryContainer,
                          ),
                    ),
                  ],
                ),
              ),
              // Meta chips (contact time, rinse)
              if (showMeta)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _MetaChip(
                        icon: Icons.timer_outlined, label: contactTime),
                    const SizedBox(height: 6),
                    _MetaChip(
                      icon: noRinse
                          ? Icons.do_not_disturb_alt_outlined
                          : Icons.water_drop_outlined,
                      label: noRinse
                          ? t.dosage_screen.rinse.no
                          : t.dosage_screen.rinse.yes,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _MetaChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onPrimaryContainer;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color.withValues(alpha: 0.8)),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color),
        ),
      ],
    );
  }
}
