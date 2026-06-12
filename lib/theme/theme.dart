import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff655900),
      surfaceTint: Color(0xff655900),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xfffbe311),
      onPrimaryContainer: Color(0xff3e3500),
      secondary: Color(0xff5f5e41),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffe4e2bd),
      onSecondaryContainer: Color(0xff47462b),
      tertiary: Color(0xff5c4a35),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffe4ccaf),
      onTertiaryContainer: Color(0xff443320),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff9e8),
      onSurface: Color(0xff1d1b10),
      onSurfaceVariant: Color(0xff4b4733),
      outline: Color(0xff7c7861),
      outlineVariant: Color(0xffcdc7a9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff333024),
      inversePrimary: Color(0xffd5bd00),
      primaryFixed: Color(0xfff3d800),
      onPrimaryFixed: Color(0xff221b00),
      primaryFixedDim: Color(0xffd5bd00),
      onPrimaryFixedVariant: Color(0xff4e4400),
      secondaryFixed: Color(0xffe4e2bd),
      onSecondaryFixed: Color(0xff1c1c04),
      secondaryFixedDim: Color(0xffc8c6a2),
      onSecondaryFixedVariant: Color(0xff47462b),
      tertiaryFixed: Color(0xffe4ccaf),
      onTertiaryFixed: Color(0xff1a0e00),
      tertiaryFixedDim: Color(0xffc7b095),
      onTertiaryFixedVariant: Color(0xff443320),
      surfaceDim: Color(0xffdfd9c9),
      surfaceBright: Color(0xfffff9e8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff9f3e3),
      surfaceContainer: Color(0xfff3eddd),
      surfaceContainerHigh: Color(0xffede8d8),
      surfaceContainerHighest: Color(0xffe8e2d2),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff433a00),
      surfaceTint: Color(0xff655900),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff7e6e00),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff363522),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff757356),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff332210),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff73604a),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff9e8),
      onSurface: Color(0xff121007),
      onSurfaceVariant: Color(0xff3a3724),
      outline: Color(0xff57533e),
      outlineVariant: Color(0xff726d56),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff333024),
      inversePrimary: Color(0xffd5bd00),
      primaryFixed: Color(0xff7e6e00),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff635600),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff757356),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff5c5b3f),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff73604a),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff5a4834),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffcbc6b7),
      surfaceBright: Color(0xfffff9e8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff9f3e3),
      surfaceContainer: Color(0xffede8d8),
      surfaceContainerHigh: Color(0xffe2dccd),
      surfaceContainerHighest: Color(0xffd6d1c2),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff362d00),
      surfaceTint: Color(0xff655900),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff564800),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2b2b14),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff4a492e),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff281805),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff473623),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff9e8),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff302d1b),
      outlineVariant: Color(0xff4e4a36),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff333024),
      inversePrimary: Color(0xffd5bd00),
      primaryFixed: Color(0xff564800),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff3c3200),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff4a492e),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff333219),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff473623),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff30200e),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbdb8a9),
      surfaceBright: Color(0xfffff9e8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f0e0),
      surfaceContainer: Color(0xffe8e2d2),
      surfaceContainerHigh: Color(0xffdad4c5),
      surfaceContainerHighest: Color(0xffccc7b8),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffbe311),
      surfaceTint: Color(0xffd5bd00),
      onPrimary: Color(0xff393000),
      primaryContainer: Color(0xfffbe311),
      onPrimaryContainer: Color(0xff261606),
      secondary: Color(0xffc8c6a2),
      onSecondary: Color(0xff313117),
      secondaryContainer: Color(0xff47462b),
      onSecondaryContainer: Color(0xffe4e2bd),
      tertiary: Color(0xffc7b095),
      onTertiary: Color(0xff2d1f0c),
      tertiaryContainer: Color(0xff443320),
      onTertiaryContainer: Color(0xffe4ccaf),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff261606),
      onSurface: Color(0xffe8e2d2),
      onSurfaceVariant: Color(0xffcdc7a9),
      outline: Color(0xff969076),
      outlineVariant: Color(0xff4b4733),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe8e2d2),
      inversePrimary: Color(0xff655900),
      primaryFixed: Color(0xfff3d800),
      onPrimaryFixed: Color(0xff221b00),
      primaryFixedDim: Color(0xffd5bd00),
      onPrimaryFixedVariant: Color(0xff4e4400),
      secondaryFixed: Color(0xffe4e2bd),
      onSecondaryFixed: Color(0xff1c1c04),
      secondaryFixedDim: Color(0xffc8c6a2),
      onSecondaryFixedVariant: Color(0xff47462b),
      tertiaryFixed: Color(0xffe4ccaf),
      onTertiaryFixed: Color(0xff1a0e00),
      tertiaryFixedDim: Color(0xffc7b095),
      onTertiaryFixedVariant: Color(0xff443320),
      surfaceDim: Color(0xff261606),
      surfaceBright: Color(0xff4a3828),
      surfaceContainerLowest: Color(0xff1a0e00),
      surfaceContainerLow: Color(0xff2e1e0e),
      surfaceContainer: Color(0xff332313),
      surfaceContainerHigh: Color(0xff3e2e1d),
      surfaceContainerHighest: Color(0xff4a3928),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffe84a),
      surfaceTint: Color(0xffd5bd00),
      onPrimary: Color(0xff2c2500),
      primaryContainer: Color(0xffd5bd00),
      onPrimaryContainer: Color(0xff100d00),
      secondary: Color(0xffdedcb6),
      onSecondary: Color(0xff262609),
      secondaryContainer: Color(0xff92906f),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffddc5a8),
      onTertiary: Color(0xff221504),
      tertiaryContainer: Color(0xff907b63),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff261606),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffe3ddbf),
      outline: Color(0xffb7b298),
      outlineVariant: Color(0xff959078),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe8e2d2),
      inversePrimary: Color(0xff4e4400),
      primaryFixed: Color(0xfff3d800),
      onPrimaryFixed: Color(0xff150f00),
      primaryFixedDim: Color(0xffd5bd00),
      onPrimaryFixedVariant: Color(0xff3c3200),
      secondaryFixed: Color(0xffe4e2bd),
      onSecondaryFixed: Color(0xff111100),
      secondaryFixedDim: Color(0xffc8c6a2),
      onSecondaryFixedVariant: Color(0xff373620),
      tertiaryFixed: Color(0xffe4ccaf),
      onTertiaryFixed: Color(0xff0f0500),
      tertiaryFixedDim: Color(0xffc7b095),
      onTertiaryFixedVariant: Color(0xff332312),
      surfaceDim: Color(0xff261606),
      surfaceBright: Color(0xff4f3d2d),
      surfaceContainerLowest: Color(0xff1a0e00),
      surfaceContainerLow: Color(0xff2e1e0e),
      surfaceContainer: Color(0xff382818),
      surfaceContainerHigh: Color(0xff433322),
      surfaceContainerHighest: Color(0xff4f3e2d),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffffbe6),
      surfaceTint: Color(0xffd5bd00),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffd1b900),
      onPrimaryContainer: Color(0xff0a0800),
      secondary: Color(0xfff8f5cf),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffc4c29e),
      onSecondaryContainer: Color(0xff0b0b00),
      tertiary: Color(0xfff8e0c3),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffc3ac91),
      onTertiaryContainer: Color(0xff080300),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff261606),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfff7f1d2),
      outlineVariant: Color(0xffc9c3a6),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe8e2d2),
      inversePrimary: Color(0xff4e4400),
      primaryFixed: Color(0xfff3d800),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffd5bd00),
      onPrimaryFixedVariant: Color(0xff150f00),
      secondaryFixed: Color(0xffe4e2bd),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffc8c6a2),
      onSecondaryFixedVariant: Color(0xff111100),
      tertiaryFixed: Color(0xffe4ccaf),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffc7b095),
      onTertiaryFixedVariant: Color(0xff0f0500),
      surfaceDim: Color(0xff261606),
      surfaceBright: Color(0xff564434),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff2e1e0e),
      surfaceContainer: Color(0xff3e2e1d),
      surfaceContainerHigh: Color(0xff4a3928),
      surfaceContainerHighest: Color(0xff564434),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  /// Custom Color 1 — Aureolin accent
  static const customColor1 = ExtendedColor(
    seed: Color(0xfffbe311),
    value: Color(0xfffbe311),
    light: ColorFamily(
      color: Color(0xff655900),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xfffbe311),
      onColorContainer: Color(0xff3e3500),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff433a00),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xfffbe311),
      onColorContainer: Color(0xff3e3500),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff362d00),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xfffbe311),
      onColorContainer: Color(0xff3e3500),
    ),
    dark: ColorFamily(
      color: Color(0xfffbe311),
      onColor: Color(0xff393000),
      colorContainer: Color(0xffd5bd00),
      onColorContainer: Color(0xff221b00),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffffe84a),
      onColor: Color(0xff2c2500),
      colorContainer: Color(0xffd5bd00),
      onColorContainer: Color(0xff100d00),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xfffffbe6),
      onColor: Color(0xff000000),
      colorContainer: Color(0xffd1b900),
      onColorContainer: Color(0xff0a0800),
    ),
  );

  List<ExtendedColor> get extendedColors => [customColor1];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
