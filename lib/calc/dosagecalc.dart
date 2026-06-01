enum DosageType { starSan, saniClean, pbw, chemiproOxi, custom }

enum DosageUnit { milliliter, gram }

enum PbwMode { coldSide, hotSide }

typedef ConversionFunction = double Function(double waterLiters);

class DosageCalculation {
  final DosageType type;
  final DosageUnit unit;
  final double ratePerLiter;
  final bool noRinse;
  final ConversionFunction conversionFn;

  static const Map<DosageType, double> _rates = {
    DosageType.starSan: 1.5,
    DosageType.saniClean: 2.6,
    DosageType.chemiproOxi: 4.0,
  };

  static const Map<DosageType, DosageUnit> _units = {
    DosageType.starSan: DosageUnit.milliliter,
    DosageType.saniClean: DosageUnit.milliliter,
    DosageType.pbw: DosageUnit.gram,
    DosageType.chemiproOxi: DosageUnit.gram,
  };

  static const Map<DosageType, bool> _noRinse = {
    DosageType.starSan: true,
    DosageType.saniClean: true,
    DosageType.pbw: false,
    DosageType.chemiproOxi: true,
  };

  static const double _pbwColdSideRate = 6.0;
  static const double _pbwHotSideRate = 10.0;

  DosageCalculation._(this.type, this.unit, this.ratePerLiter, this.noRinse)
      : conversionFn = ((waterLiters) => waterLiters * ratePerLiter);

  factory DosageCalculation({
    required DosageType type,
    PbwMode pbwMode = PbwMode.coldSide,
    double? customFactor,
    DosageUnit? customUnit,
  }) {
    if (type == DosageType.custom) {
      if (customFactor == null || customUnit == null) {
        throw ArgumentError(
          'customFactor and customUnit must be provided for custom dosage',
        );
      }
      return DosageCalculation._(type, customUnit, customFactor, true);
    }

    if (type == DosageType.pbw) {
      final rate = pbwMode == PbwMode.coldSide ? _pbwColdSideRate : _pbwHotSideRate;
      return DosageCalculation._(type, _units[type]!, rate, _noRinse[type]!);
    }

    return DosageCalculation._(type, _units[type]!, _rates[type]!, _noRinse[type]!);
  }

  double amountFor(double waterLiters) => conversionFn(waterLiters);
}
