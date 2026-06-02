class WeightUnitCalc {
  // Base unit is Grams
  static double kgToGrams(double kg) => kg * 1000;
  static double gramsToKg(double g) => g / 1000;

  static double lbsToGrams(double lbs) => lbs * 453.59237;
  static double gramsToLbs(double g) => g / 453.59237;

  static double ozToGrams(double oz) => oz * 28.349523125;
  static double gramsToOz(double g) => g / 28.349523125;

  static double stToGrams(double st) => st * 6350.29318;
  static double gramsToSt(double g) => g / 6350.29318;
}

class TempUnitCalc {
  // Base unit is Celsius
  static double fToC(double f) => (f - 32) * 5 / 9;
  static double cToF(double c) => (c * 9 / 5) + 32;

  static double kToC(double k) => k - 273.15;
  static double cToK(double c) => c + 273.15;
}
