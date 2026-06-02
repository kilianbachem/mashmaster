import 'package:mashmaster/calc/general_calc.dart';

class HydrometerCorrection {
  /// Default hydrometer calibration temperature in °C
  /// (20°C / 68°F is the de-facto European standard).
  static const double defaultCalibrationTempC = 20.0;

  /// Corrects a hydrometer reading for the actual temperature of the wort.
  ///
  /// Returns the corrected gravity in the same [unit] as the input,
  /// or null if inputs are invalid.
  static double? correct({
    required double measuredGravity,
    required GravityUnit unit,
    required double wortTempC,
    required double calibrationTempC,
  }) {
    if (measuredGravity < 0) return null;

    // Convert measured value to SG for the correction math.
    final measuredSg = unit == GravityUnit.plato
        ? GravityConversion.platoToSg(measuredGravity)
        : measuredGravity;

    // ASBC formula operates in °F.
    final tw = _celsiusToFahrenheit(wortTempC);
    final tc = _celsiusToFahrenheit(calibrationTempC);

    final divisor = _factor(tc);
    if (divisor == 0) return null;
    final correctedSg = measuredSg * (_factor(tw) / divisor);

    return unit == GravityUnit.plato
        ? GravityConversion.sgToPlato(correctedSg)
        : correctedSg;
  }

  static double _celsiusToFahrenheit(double c) => c * 9 / 5 + 32;

  /// ASBC density-correction polynomial (water density vs. 60°F reference).
  static double _factor(double tempF) =>
      1.00130346 -
      0.000134722124 * tempF +
      0.00000204052596 * tempF * tempF -
      0.00000000232820948 * tempF * tempF * tempF;
}
