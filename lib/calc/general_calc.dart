enum GravityUnit { specificGravity, plato }

/// Aggregated brew statistics derived from Original and Final Gravity.
class BrewStats {
  final double abv; // % vol.
  final double abw; // % weight
  final double kcalPer100ml;
  final double kjPer100ml;
  final double carbsPer100ml; // grams
  final double apparentAttenuation; // %
  final double realAttenuation; // %
  final double originalExtractPlato; // °P
  final double apparentExtractPlato; // °P
  final double realExtractPlato; // °P (Balling)
  final double ogSg;
  final double fgSg;

  const BrewStats({
    required this.abv,
    required this.abw,
    required this.kcalPer100ml,
    required this.kjPer100ml,
    required this.carbsPer100ml,
    required this.apparentAttenuation,
    required this.realAttenuation,
    required this.originalExtractPlato,
    required this.apparentExtractPlato,
    required this.realExtractPlato,
    required this.ogSg,
    required this.fgSg,
  });
}

/// Conversion helpers between specific gravity (SG) and °Plato.
class GravityConversion {
  /// °Plato → SG (de Clerck approximation).
  static double platoToSg(double plato) =>
      1 + plato / (258.6 - ((plato / 258.2) * 227.1));

  /// SG → °Plato (cubic approximation, ASBC).
  static double sgToPlato(double sg) =>
      (-616.868) + (1111.14 * sg) - (630.272 * sg * sg) + (135.997 * sg * sg * sg);
}

class GeneralCalculation {
  /// Compute [BrewStats] from Original and Final Gravity readings.
  ///
  /// Returns null if inputs are non-positive or if FG exceeds OG
  /// (would imply impossible negative fermentation).
  static BrewStats? fromGravities({
    required double og,
    required double fg,
    required GravityUnit unit,
  }) {
    if (og <= 0 || fg < 0) return null;

    final double ogPlato;
    final double fgPlato;
    final double ogSg;
    final double fgSg;

    if (unit == GravityUnit.plato) {
      ogPlato = og;
      fgPlato = fg;
      ogSg = GravityConversion.platoToSg(og);
      fgSg = GravityConversion.platoToSg(fg);
    } else {
      ogSg = og;
      fgSg = fg;
      ogPlato = GravityConversion.sgToPlato(og);
      fgPlato = GravityConversion.sgToPlato(fg);
    }

    if (fgPlato > ogPlato) return null;
    if (ogPlato <= 0) return null;

    final abv = (ogSg - fgSg) * 131.25;
    final abw = fgSg == 0 ? 0.0 : abv * 0.7936 / fgSg;

    // Balling real extract approximation.
    final realExtractPlato = (0.1808 * ogPlato) + (0.8192 * fgPlato);

    final apparentAttenuation = (ogPlato - fgPlato) / ogPlato * 100;
    final realAttenuation = (ogPlato - realExtractPlato) / ogPlato * 100;

    // Brewer's Friend formula for kcal/12oz, scaled to per-100ml.
    // 12 oz ≈ 354.88 ml so per-100ml ≈ kcal_per_12oz / 3.5488.
    // Algebraic simplification yields ≈ (6.9·ABW + 4·(RE−0.1)) · FG_SG.
    final kcalPer100ml =
        (6.9 * abw + 4.0 * (realExtractPlato - 0.1)) * fgSg;
    final kjPer100ml = kcalPer100ml * 4.184;

    // Carbohydrates approximated as residual real extract (g per 100ml).
    final carbsPer100ml = realExtractPlato * fgSg;

    return BrewStats(
      abv: abv,
      abw: abw,
      kcalPer100ml: kcalPer100ml,
      kjPer100ml: kjPer100ml,
      carbsPer100ml: carbsPer100ml,
      apparentAttenuation: apparentAttenuation,
      realAttenuation: realAttenuation,
      originalExtractPlato: ogPlato,
      apparentExtractPlato: fgPlato,
      realExtractPlato: realExtractPlato,
      ogSg: ogSg,
      fgSg: fgSg,
    );
  }
}
