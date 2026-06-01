import 'package:mashmaster/calc/general_calc.dart';

class RefractometerResult {
  final double gravityPlato;
  final double gravitySg;
  final double? abv;
  final double? abw;

  const RefractometerResult({
    required this.gravityPlato,
    required this.gravitySg,
    this.abv,
    this.abw,
  });
}

class RefractometerCalculation {
  /// Unfermented wort: simple Brix-to-Plato via correction factor.
  ///
  /// Returns null if inputs are non-positive.
  static RefractometerResult? unfermented({
    required double brixWri,
    required double correctionFactor,
  }) {
    if (brixWri < 0 || correctionFactor <= 0) return null;

    final correctedBrix = brixWri / correctionFactor;
    final sg = GravityConversion.platoToSg(correctedBrix);

    return RefractometerResult(
      gravityPlato: correctedBrix,
      gravitySg: sg,
    );
  }

  /// Fermented wort: correct refractometer reading for alcohol presence.
  ///
  /// Uses the Terrill cubic formula to derive actual FG from the OG (°Plato)
  /// and the current Brix refractometer reading.
  ///
  /// Returns null if inputs are invalid or FG exceeds OG.
  static RefractometerResult? fermented({
    required double ogPlato,
    required double brixWri,
    required double correctionFactor,
  }) {
    if (ogPlato <= 0 || brixWri < 0 || correctionFactor <= 0) return null;

    final correctedBrix = brixWri / correctionFactor;

    // Terrill cubic: OG in °Plato, corrected Brix → FG in SG.
    final og = ogPlato;
    final cb = correctedBrix;
    final fgSg = 1.001843 -
        0.002318474 * og -
        0.000007775 * og * og -
        0.000000034 * og * og * og +
        0.00574 * cb +
        0.00003344 * cb * cb +
        0.000000086 * cb * cb * cb;

    final fgPlato = GravityConversion.sgToPlato(fgSg);
    if (fgPlato > ogPlato) return null;

    final ogSg = GravityConversion.platoToSg(ogPlato);
    final abv = (ogSg - fgSg) * 131.25;
    final abw = fgSg == 0 ? 0.0 : abv * 0.7936 / fgSg;

    return RefractometerResult(
      gravityPlato: fgPlato,
      gravitySg: fgSg,
      abv: abv,
      abw: abw,
    );
  }
}
