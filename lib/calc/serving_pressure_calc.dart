import 'package:mashmaster/calc/carbonation_calc.dart';

/// Inner diameter of the beer line.
enum LineDiameter {
  /// 4 mm — typical for short party taps or compensator taps.
  mm4,

  /// 7 mm — standard homebrew beer line (John Guest / EVABarrier).
  mm7,

  /// 10 mm — large-diameter commercial line.
  mm10,
}

/// Breakdown of the required serving (dispensing) pressure.
class ServingPressureResult {
  /// CO₂ equilibrium pressure at the given temperature & carbonation (bar).
  final double saturationPressureBar;

  /// Pressure lost to friction in the beer line (bar).
  final double lineLossBar;

  /// Pressure needed to overcome the height difference (bar).
  /// Positive when the tap is above the keg.
  final double heightLossBar;

  /// Fixed safety margin (bar).
  final double safetyMarginBar;

  /// Total required serving pressure (bar, gauge).
  final double totalPressureBar;

  const ServingPressureResult({
    required this.saturationPressureBar,
    required this.lineLossBar,
    required this.heightLossBar,
    required this.safetyMarginBar,
    required this.totalPressureBar,
  });
}

class ServingPressureCalculation {
  /// Friction loss per metre of beer line at ~3 L/min flow rate.
  /// Source: braumagazin.de — Zapftechnik in der Praxis, Teil 2.
  static const Map<LineDiameter, double> lineResistance = {
    LineDiameter.mm4: 0.72,
    LineDiameter.mm7: 0.05,
    LineDiameter.mm10: 0.01,
  };

  /// Hydrostatic pressure per metre of elevation: 0.1 bar/m.
  static const double heightFactor = 0.1;

  /// Small safety buffer added to the final pressure.
  static const double safetyMargin = 0.1;

  /// Human-readable label for a [LineDiameter].
  static String diameterLabel(LineDiameter d) {
    switch (d) {
      case LineDiameter.mm4:
        return '4 mm';
      case LineDiameter.mm7:
        return '7 mm';
      case LineDiameter.mm10:
        return '10 mm';
    }
  }

  /// Calculate the required serving pressure.
  ///
  /// [co2GramsPerLiter] – desired carbonation level in g/L.
  /// [beerTempC] – temperature of the beer in the keg (°C).
  /// [lineLengthM] – length of the beer line from keg to tap (m).
  /// [lineDiameter] – inner diameter of the beer line.
  /// [heightDifferenceM] – vertical distance from keg centre to tap (m).
  ///   Positive when the tap is above the keg (typical setup).
  static ServingPressureResult calculate({
    required double co2GramsPerLiter,
    required double beerTempC,
    required double lineLengthM,
    required LineDiameter lineDiameter,
    required double heightDifferenceM,
  }) {
    // Reuse the Brewer's Friend polynomial to get the equilibrium
    // (saturation) pressure for the given CO₂ level and temperature.
    final saturation = CarbonationCalculation.forcePressure(
      targetCo2GramsPerLiter: co2GramsPerLiter,
      carbonationTempC: beerTempC,
    ).bar;

    final lineLoss = lineResistance[lineDiameter]! * lineLengthM;
    final heightLoss = heightDifferenceM * heightFactor;

    final total = saturation + lineLoss + heightLoss + safetyMargin;

    return ServingPressureResult(
      saturationPressureBar: saturation,
      lineLossBar: lineLoss,
      heightLossBar: heightLoss,
      safetyMarginBar: safetyMargin,
      totalPressureBar: total < 0 ? 0 : total,
    );
  }
}
