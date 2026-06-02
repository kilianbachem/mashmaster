enum CarbonationMethod { bottleSugar, kegSugar, kegForce }

class CarbonationSugarResult {
  /// Table sugar (sucrose) needed in grams.
  final double sugarGrams;

  /// Residual CO2 already in the beer from fermentation (g/L).
  final double residualCo2GramsPerLiter;

  /// Net CO2 still required to reach the target (g).
  final double co2NeededGrams;

  const CarbonationSugarResult({
    required this.sugarGrams,
    required this.residualCo2GramsPerLiter,
    required this.co2NeededGrams,
  });
}

class CarbonationPressureResult {
  /// Required regulator pressure in bar (gauge, above atmospheric).
  final double bar;

  const CarbonationPressureResult({required this.bar});
}

class CarbonationCalculation {
  /// 1 volume CO2 ≈ 1.96 g/L (Brewer's standard conversion).
  static const double gramsPerLiterPerVolume = 1.96;

  /// Yield of one gram table sugar (sucrose) when fully fermented: g CO2.
  /// Theoretical max 0.514, brewers use 0.5 for predictable real-world yield.
  static const double sucroseCo2Yield = 0.5;

  /// Residual CO2 still dissolved in beer after fermentation, in g/L.
  ///
  /// Uses the empirical formula from Greg Noonan via Designing Great Beers,
  /// which takes the peak (highest) fermentation temperature into account.
  static double residualCo2GramsPerLiter(double peakFermentationTempC) {
    final tF = _celsiusToFahrenheit(peakFermentationTempC);
    final volumes = 3.0378 - 0.050062 * tF + 0.00026555 * tF * tF;
    return volumes * gramsPerLiterPerVolume;
  }

  /// Table sugar needed for natural bottle conditioning.
  static CarbonationSugarResult bottleSugar({
    required double targetCo2GramsPerLiter,
    required double bottlingVolumeLiters,
    required double peakFermentationTempC,
  }) {
    final residual = residualCo2GramsPerLiter(peakFermentationTempC);
    final delta = (targetCo2GramsPerLiter - residual).clamp(0, double.infinity);
    final co2NeededGrams = delta * bottlingVolumeLiters;
    final sugar = co2NeededGrams / sucroseCo2Yield;
    return CarbonationSugarResult(
      sugarGrams: sugar,
      residualCo2GramsPerLiter: residual,
      co2NeededGrams: co2NeededGrams,
    );
  }

  /// Table sugar needed for keg priming.
  ///
  /// Industry rule of thumb: roughly half the bottle priming amount,
  /// because the keg headspace pressurises quickly and pushes CO2 back
  /// into solution faster.
  static CarbonationSugarResult kegSugar({
    required double targetCo2GramsPerLiter,
    required double kegVolumeLiters,
    required double peakFermentationTempC,
  }) {
    final bottle = bottleSugar(
      targetCo2GramsPerLiter: targetCo2GramsPerLiter,
      bottlingVolumeLiters: kegVolumeLiters,
      peakFermentationTempC: peakFermentationTempC,
    );
    return CarbonationSugarResult(
      sugarGrams: bottle.sugarGrams / 2,
      residualCo2GramsPerLiter: bottle.residualCo2GramsPerLiter,
      co2NeededGrams: bottle.co2NeededGrams,
    );
  }

  /// Required regulator gauge pressure (bar) for force carbonation.
  ///
  /// Brewer's Friend polynomial: relates temperature and target CO2
  /// to the equilibrium head pressure above the beer.
  static CarbonationPressureResult forcePressure({
    required double targetCo2GramsPerLiter,
    required double carbonationTempC,
  }) {
    final tF = _celsiusToFahrenheit(carbonationTempC);
    final v = targetCo2GramsPerLiter / gramsPerLiterPerVolume;
    final psi = -16.6999 -
        0.0101059 * tF +
        0.00116512 * tF * tF +
        0.173354 * tF * v +
        4.24267 * v -
        0.0684226 * v * v;
    final bar = psi * 0.0689476;
    return CarbonationPressureResult(bar: bar < 0 ? 0 : bar);
  }

  static double _celsiusToFahrenheit(double c) => c * 9 / 5 + 32;
}
