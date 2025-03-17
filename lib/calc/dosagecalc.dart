enum DosageType { pbw, chemiproOxi, starSan, custom }

typedef ConversionFunction = double Function(double input);

class DosageCalculation {
  final DosageType type;
  final double conversionFactor;
  final ConversionFunction conversionFn;

  //Pre-Defined Conversions //FUTURE plug in the real conversion factors
  static const Map<DosageType, double> _predefinedFactors = {
    DosageType.pbw: 1.5,
    DosageType.chemiproOxi: 3.8,
    DosageType.starSan: 119.0,
  };

  DosageCalculation._(this.type, this.conversionFactor, this.conversionFn);

  factory DosageCalculation({required DosageType type, double? customFactor}) {
    double factor;

    if (type == DosageType.custom) {
      if (customFactor == null) {
        throw ArgumentError(
          "A custom factor must be provided for custom conversion",
        );
      }
      factor = customFactor;
    } else {
      factor = _predefinedFactors[type]!;
    }

    return DosageCalculation._(type, factor, (input) => input * factor);
  }

  double convert(double input) => conversionFn(input);
}
