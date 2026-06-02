///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element

class Translations implements BaseTranslations<AppLocale, Translations> {
  /// Returns the current translations of the given [context].
  ///
  /// Usage:
  /// final t = Translations.of(context);
  static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
    : assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
      $meta = TranslationMetadata(
        locale: AppLocale.en,
        overrides: overrides ?? {},
        cardinalResolver: cardinalResolver,
        ordinalResolver: ordinalResolver,
      ) {
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <en>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  dynamic operator [](String key) => $meta.getTranslation(key);

  late final Translations _root = this; // ignore: unused_field

  // Translations
  String get app_title => 'MashMaster';
  late final TranslationsLanguageEn language = TranslationsLanguageEn.internal(_root);
  late final TranslationsNavbarEn navbar = TranslationsNavbarEn.internal(_root);
  late final TranslationsRoutesEn routes = TranslationsRoutesEn.internal(_root);
  late final TranslationsGenericEn generic = TranslationsGenericEn.internal(_root);
  late final TranslationsHomeScreenCardsEn home_screen_cards = TranslationsHomeScreenCardsEn.internal(_root);
  late final TranslationsContactScreenEn contact_screen = TranslationsContactScreenEn.internal(_root);
  late final TranslationsSettingsScreenEn settings_screen = TranslationsSettingsScreenEn.internal(_root);
  late final TranslationsGeneralScreenEn general_screen = TranslationsGeneralScreenEn.internal(_root);
  late final TranslationsRefractometerScreenEn refractometer_screen = TranslationsRefractometerScreenEn.internal(_root);
  late final TranslationsHydrometerScreenEn hydrometer_screen = TranslationsHydrometerScreenEn.internal(_root);
  late final TranslationsCarbonationScreenEn carbonation_screen = TranslationsCarbonationScreenEn.internal(_root);
  late final TranslationsDosageScreenEn dosage_screen = TranslationsDosageScreenEn.internal(_root);
}

// Path: language
class TranslationsLanguageEn {
  TranslationsLanguageEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get label => 'Language';
  String get en => 'English';
  String get de => 'German';
}

// Path: navbar
class TranslationsNavbarEn {
  TranslationsNavbarEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get home => 'Home';
  String get contact => 'Contact';
}

// Path: routes
class TranslationsRoutesEn {
  TranslationsRoutesEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get main => _root.app_title;
  String get main_dosage => _root.home_screen_cards.dosage_calc.title;
  String get main_general => _root.home_screen_cards.general_calc.title;
  String get main_brew => _root.home_screen_cards.brew_calc.title;
  String get main_unit => _root.home_screen_cards.unit_calc.title;
  String get main_mash => _root.home_screen_cards.mash_calc.title;
  String get contact => 'Contact';
  String get settings => 'App Settings';
}

// Path: generic
class TranslationsGenericEn {
  TranslationsGenericEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get placeholder_label => 'This feature has not been finalized yet.\nPlease come back later!';
  String get cta_label => 'I want this feature sooner!';
}

// Path: home_screen_cards
class TranslationsHomeScreenCardsEn {
  TranslationsHomeScreenCardsEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsHomeScreenCardsDosageCalcEn dosage_calc = TranslationsHomeScreenCardsDosageCalcEn.internal(_root);
  late final TranslationsHomeScreenCardsGeneralCalcEn general_calc = TranslationsHomeScreenCardsGeneralCalcEn.internal(_root);
  late final TranslationsHomeScreenCardsBrewCalcEn brew_calc = TranslationsHomeScreenCardsBrewCalcEn.internal(_root);
  late final TranslationsHomeScreenCardsUnitCalcEn unit_calc = TranslationsHomeScreenCardsUnitCalcEn.internal(_root);
  late final TranslationsHomeScreenCardsMashCalcEn mash_calc = TranslationsHomeScreenCardsMashCalcEn.internal(_root);
}

// Path: contact_screen
class TranslationsContactScreenEn {
  TranslationsContactScreenEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get label_one => 'For Feedback, Suggestions and other Comments';
  late final TranslationsContactScreenDevCardEn dev_card = TranslationsContactScreenDevCardEn.internal(_root);
  late final TranslationsContactScreenBugReportEn bug_report = TranslationsContactScreenBugReportEn.internal(_root);
  String get version_label => 'Made with ♡ in Vallendar.';
}

// Path: settings_screen
class TranslationsSettingsScreenEn {
  TranslationsSettingsScreenEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get theme_switch => 'Dark Mode';
  String get system_theme_switch => 'Use System Theme';
  late final TranslationsSettingsScreenDeleteAppDataEn delete_app_data = TranslationsSettingsScreenDeleteAppDataEn.internal(_root);
  String get placeholder_label => 'There are currently very few settings for this app, since it is still in Beta.\n\nPlease come back later!';
}

// Path: general_screen
class TranslationsGeneralScreenEn {
  TranslationsGeneralScreenEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsGeneralScreenSectionEn section = TranslationsGeneralScreenSectionEn.internal(_root);
  late final TranslationsGeneralScreenLabelsEn labels = TranslationsGeneralScreenLabelsEn.internal(_root);
  late final TranslationsGeneralScreenUnitsEn units = TranslationsGeneralScreenUnitsEn.internal(_root);
  String get per_100ml => 'per 100 ml';
  late final TranslationsGeneralScreenHintEn hint = TranslationsGeneralScreenHintEn.internal(_root);
  String get info => 'Enter Original Gravity (OG) and Final Gravity (FG) to calculate ABV, attenuation and calories.';
  late final TranslationsGeneralScreenTabsEn tabs = TranslationsGeneralScreenTabsEn.internal(_root);
}

// Path: refractometer_screen
class TranslationsRefractometerScreenEn {
  TranslationsRefractometerScreenEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get fermented_wort => 'Fermented wort?';
  late final TranslationsRefractometerScreenLabelsEn labels = TranslationsRefractometerScreenLabelsEn.internal(_root);
  late final TranslationsRefractometerScreenHintEn hint = TranslationsRefractometerScreenHintEn.internal(_root);
  String get info =>
      'Enter your refractometer Brix reading to get your gravity measurement. If the wort is fermented you also have to enter your original gravity measurement.';
}

// Path: hydrometer_screen
class TranslationsHydrometerScreenEn {
  TranslationsHydrometerScreenEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsHydrometerScreenLabelsEn labels = TranslationsHydrometerScreenLabelsEn.internal(_root);
  late final TranslationsHydrometerScreenHintEn hint = TranslationsHydrometerScreenHintEn.internal(_root);
  String get info =>
      'Enter your measured gravity and wort temperature to get the temperature-corrected gravity. The hydrometer calibration temperature is optional.';
}

// Path: carbonation_screen
class TranslationsCarbonationScreenEn {
  TranslationsCarbonationScreenEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsCarbonationScreenLabelsEn labels = TranslationsCarbonationScreenLabelsEn.internal(_root);
  late final TranslationsCarbonationScreenMethodsEn methods = TranslationsCarbonationScreenMethodsEn.internal(_root);
  late final TranslationsCarbonationScreenHintEn hint = TranslationsCarbonationScreenHintEn.internal(_root);
  late final TranslationsCarbonationScreenResultEn result = TranslationsCarbonationScreenResultEn.internal(_root);
  String get info =>
      'Pick a method and beer style. For natural carbonation with sugar, the peak fermentation temperature matters — it determines how much CO₂ is already dissolved in the beer.';
}

// Path: dosage_screen
class TranslationsDosageScreenEn {
  TranslationsDosageScreenEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsDosageScreenSectionEn section = TranslationsDosageScreenSectionEn.internal(_root);
  String get water_hint => 'e.g., 20';
  late final TranslationsDosageScreenProductsEn products = TranslationsDosageScreenProductsEn.internal(_root);
  late final TranslationsDosageScreenPbwModeEn pbw_mode = TranslationsDosageScreenPbwModeEn.internal(_root);
  late final TranslationsDosageScreenCustomEn custom = TranslationsDosageScreenCustomEn.internal(_root);
  late final TranslationsDosageScreenResultEn result = TranslationsDosageScreenResultEn.internal(_root);
  late final TranslationsDosageScreenRinseEn rinse = TranslationsDosageScreenRinseEn.internal(_root);
  late final TranslationsDosageScreenContactTimeEn contact_time = TranslationsDosageScreenContactTimeEn.internal(_root);
}

// Path: home_screen_cards.dosage_calc
class TranslationsHomeScreenCardsDosageCalcEn {
  TranslationsHomeScreenCardsDosageCalcEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Cleaning Agent Dosing Tool';
  String get subtitle => 'e.g., PBW, StarSan, SaniClean, ChemiPro Oxi';
}

// Path: home_screen_cards.general_calc
class TranslationsHomeScreenCardsGeneralCalcEn {
  TranslationsHomeScreenCardsGeneralCalcEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'General Calculations';
  String get subtitle => 'ABV (%vol), Calories, Refractometer, Boil-Off Rate, Hydrometer Correction, Carbonation';
}

// Path: home_screen_cards.brew_calc
class TranslationsHomeScreenCardsBrewCalcEn {
  TranslationsHomeScreenCardsBrewCalcEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Brewing Conversions';
  String get subtitle => 'Extract Levels, Beer Color';
}

// Path: home_screen_cards.unit_calc
class TranslationsHomeScreenCardsUnitCalcEn {
  TranslationsHomeScreenCardsUnitCalcEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Unit Conversions';
  String get subtitle => 'Volume, Weight, Temperature';
}

// Path: home_screen_cards.mash_calc
class TranslationsHomeScreenCardsMashCalcEn {
  TranslationsHomeScreenCardsMashCalcEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Mash Calculations';
  String get subtitle => 'Mash-In & Mash Step Temperatures, Mash Tun Calibration';
}

// Path: contact_screen.dev_card
class TranslationsContactScreenDevCardEn {
  TranslationsContactScreenDevCardEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get name => '@NightmindOfficial';
  String get title => 'App Developer';
}

// Path: contact_screen.bug_report
class TranslationsContactScreenBugReportEn {
  TranslationsContactScreenBugReportEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get label => 'Want to report a bug?';
  String get button_label => 'Submit Bug Report';
}

// Path: settings_screen.delete_app_data
class TranslationsSettingsScreenDeleteAppDataEn {
  TranslationsSettingsScreenDeleteAppDataEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Delete App Data';
  String get content => 'This deletes your preference data (e.g. preferred theme mode, and language). No other data will be affected.';
  String get button_label => 'Delete Now';
  late final TranslationsSettingsScreenDeleteAppDataAlertDialogEn alert_dialog = TranslationsSettingsScreenDeleteAppDataAlertDialogEn.internal(_root);
  String get snackbar => 'Data deleted. Restart the app for the changes to take effect.';
}

// Path: general_screen.section
class TranslationsGeneralScreenSectionEn {
  TranslationsGeneralScreenSectionEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get input => 'Wort readings';
  String get result => 'Result';
}

// Path: general_screen.labels
class TranslationsGeneralScreenLabelsEn {
  TranslationsGeneralScreenLabelsEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get og => 'Original Gravity (OG)';
  String get fg => 'Final Gravity (FG)';
  String get unit => 'Unit';
  String get abv => 'Alcohol by Volume';
  String get abw => 'Alcohol by Weight';
  String get calories => 'Calories';
  String get carbs => 'Carbs';
  String get apparent_attenuation => 'Apparent Attenuation';
  String get real_attenuation => 'Real Attenuation';
  String get original_extract => 'Original Extract';
  String get apparent_extract => 'Apparent Extract';
  String get real_extract => 'Real Extract';
}

// Path: general_screen.units
class TranslationsGeneralScreenUnitsEn {
  TranslationsGeneralScreenUnitsEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get sg => 'SG';
  String get plato => '°Plato';
}

// Path: general_screen.hint
class TranslationsGeneralScreenHintEn {
  TranslationsGeneralScreenHintEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get og_plato => 'e.g. 12.5';
  String get fg_plato => 'e.g. 2.4';
  String get og_sg => 'e.g. 1.050';
  String get fg_sg => 'e.g. 1.010';
}

// Path: general_screen.tabs
class TranslationsGeneralScreenTabsEn {
  TranslationsGeneralScreenTabsEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get abv => 'ABV';
  String get refractometer => 'Refractometer';
  String get hydrometer => 'Hydrometer';
  String get carbonation => 'Carbonation';
}

// Path: refractometer_screen.labels
class TranslationsRefractometerScreenLabelsEn {
  TranslationsRefractometerScreenLabelsEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get og => 'Original Gravity (OG)';
  String get brix => 'Brix WRI';
  String get correction_factor => 'Correction Factor';
  String get gravity => 'Gravity';
  String get abv => 'ABV';
  String get abw => 'ABW';
}

// Path: refractometer_screen.hint
class TranslationsRefractometerScreenHintEn {
  TranslationsRefractometerScreenHintEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get og => 'e.g. 10.48';
  String get brix => 'e.g. 6';
  String get correction_factor => 'e.g. 1.04';
}

// Path: hydrometer_screen.labels
class TranslationsHydrometerScreenLabelsEn {
  TranslationsHydrometerScreenLabelsEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get measured_gravity => 'Measured Gravity';
  String get temperature => 'Temperature';
  String get calibration_temp => 'Calibration Temp.';
  String get corrected_gravity => 'Gravity';
}

// Path: hydrometer_screen.hint
class TranslationsHydrometerScreenHintEn {
  TranslationsHydrometerScreenHintEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get measured_plato => 'e.g. 2.6';
  String get measured_sg => 'e.g. 1.010';
  String get temperature => 'e.g. 21.7';
  String get calibration_temp => '20';
}

// Path: carbonation_screen.labels
class TranslationsCarbonationScreenLabelsEn {
  TranslationsCarbonationScreenLabelsEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get beer_style => 'Beer Style';
  String get style_range => 'Carbonation range';
  String get target_co2 => 'Carbonation';
  String get method => 'Method';
  String get bottling_volume => 'Bottling Volume';
  String get keg_volume => 'Keg Volume';
  String get peak_fermentation_temp => 'Peak Fermentation Temp';
  String get carbonation_temp => 'Carbonation Temp';
}

// Path: carbonation_screen.methods
class TranslationsCarbonationScreenMethodsEn {
  TranslationsCarbonationScreenMethodsEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get bottle_sugar => 'Bottle (sugar)';
  String get keg_sugar => 'Keg (sugar)';
  String get keg_force => 'Keg (force)';
}

// Path: carbonation_screen.hint
class TranslationsCarbonationScreenHintEn {
  TranslationsCarbonationScreenHintEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get volume => 'e.g. 20';
  String get fermentation_temp => 'e.g. 20';
  String get carbonation_temp => 'e.g. 4';
}

// Path: carbonation_screen.result
class TranslationsCarbonationScreenResultEn {
  TranslationsCarbonationScreenResultEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String sugar_bottle({required Object sugar, required Object volume, required Object temp, required Object target}) =>
      '${sugar} g table sugar in ${volume} L, fermented at max ${temp} °C, for ${target} g/L CO₂';
  String sugar_keg({required Object sugar, required Object volume, required Object temp, required Object target}) =>
      '${sugar} g table sugar in ${volume} L keg at ${temp} °C for ${target} g/L CO₂';
  String force_pressure({required Object bar, required Object temp, required Object target}) =>
      '${bar} bar at ${temp} °C for about 1 week to reach ${target} g/L CO₂';
  String current_co2({required Object co2}) => 'Currently ${co2} g/L CO₂ in the beer';
}

// Path: dosage_screen.section
class TranslationsDosageScreenSectionEn {
  TranslationsDosageScreenSectionEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get product => 'Product';
  String get application => 'Application';
  String get water => 'Water volume';
}

// Path: dosage_screen.products
class TranslationsDosageScreenProductsEn {
  TranslationsDosageScreenProductsEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get custom => 'Custom';
}

// Path: dosage_screen.pbw_mode
class TranslationsDosageScreenPbwModeEn {
  TranslationsDosageScreenPbwModeEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get cold => 'Cold side';
  String get hot => 'Kettle / hot';
}

// Path: dosage_screen.custom
class TranslationsDosageScreenCustomEn {
  TranslationsDosageScreenCustomEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get factor_label => 'Factor (amount per litre of water)';
  String get factor_hint => 'e.g., 1.5';
  String get unit_label => 'Unit';
}

// Path: dosage_screen.result
class TranslationsDosageScreenResultEn {
  TranslationsDosageScreenResultEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get label => 'You need';
}

// Path: dosage_screen.rinse
class TranslationsDosageScreenRinseEn {
  TranslationsDosageScreenRinseEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get no => 'do not rinse';
  String get yes => 'rinse well';
}

// Path: dosage_screen.contact_time
class TranslationsDosageScreenContactTimeEn {
  TranslationsDosageScreenContactTimeEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get starsan => '1–2 min';
  String get saniclean => '2–3 min';
  String get pbw => 'soak';
  String get chemipro_oxi => '2–5 min';
  String get custom => '—';
}

// Path: settings_screen.delete_app_data.alert_dialog
class TranslationsSettingsScreenDeleteAppDataAlertDialogEn {
  TranslationsSettingsScreenDeleteAppDataAlertDialogEn.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Delete Local App Data?';
  String get content =>
      'This action cannot be undone. Your preferred language, theme mode and other settings will be deleted. You need to restart the app for the changes to take effect.';
  String get abort_label => 'Keep Data';
  String get execute_label => 'Delete';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
  dynamic _flatMapFunction(String path) {
    switch (path) {
      case 'app_title':
        return 'MashMaster';
      case 'language.label':
        return 'Language';
      case 'language.en':
        return 'English';
      case 'language.de':
        return 'German';
      case 'navbar.home':
        return 'Home';
      case 'navbar.contact':
        return 'Contact';
      case 'routes.main':
        return _root.app_title;
      case 'routes.main_dosage':
        return _root.home_screen_cards.dosage_calc.title;
      case 'routes.main_general':
        return _root.home_screen_cards.general_calc.title;
      case 'routes.main_brew':
        return _root.home_screen_cards.brew_calc.title;
      case 'routes.main_unit':
        return _root.home_screen_cards.unit_calc.title;
      case 'routes.main_mash':
        return _root.home_screen_cards.mash_calc.title;
      case 'routes.contact':
        return 'Contact';
      case 'routes.settings':
        return 'App Settings';
      case 'generic.placeholder_label':
        return 'This feature has not been finalized yet.\nPlease come back later!';
      case 'generic.cta_label':
        return 'I want this feature sooner!';
      case 'home_screen_cards.dosage_calc.title':
        return 'Cleaning Agent Dosing Tool';
      case 'home_screen_cards.dosage_calc.subtitle':
        return 'e.g., PBW, StarSan, SaniClean, ChemiPro Oxi';
      case 'home_screen_cards.general_calc.title':
        return 'General Calculations';
      case 'home_screen_cards.general_calc.subtitle':
        return 'ABV (%vol), Calories, Refractometer, Boil-Off Rate, Hydrometer Correction, Carbonation';
      case 'home_screen_cards.brew_calc.title':
        return 'Brewing Conversions';
      case 'home_screen_cards.brew_calc.subtitle':
        return 'Extract Levels, Beer Color';
      case 'home_screen_cards.unit_calc.title':
        return 'Unit Conversions';
      case 'home_screen_cards.unit_calc.subtitle':
        return 'Volume, Weight, Temperature';
      case 'home_screen_cards.mash_calc.title':
        return 'Mash Calculations';
      case 'home_screen_cards.mash_calc.subtitle':
        return 'Mash-In & Mash Step Temperatures, Mash Tun Calibration';
      case 'contact_screen.label_one':
        return 'For Feedback, Suggestions and other Comments';
      case 'contact_screen.dev_card.name':
        return '@NightmindOfficial';
      case 'contact_screen.dev_card.title':
        return 'App Developer';
      case 'contact_screen.bug_report.label':
        return 'Want to report a bug?';
      case 'contact_screen.bug_report.button_label':
        return 'Submit Bug Report';
      case 'contact_screen.version_label':
        return 'Made with ♡ in Vallendar.';
      case 'settings_screen.theme_switch':
        return 'Dark Mode';
      case 'settings_screen.system_theme_switch':
        return 'Use System Theme';
      case 'settings_screen.delete_app_data.title':
        return 'Delete App Data';
      case 'settings_screen.delete_app_data.content':
        return 'This deletes your preference data (e.g. preferred theme mode, and language). No other data will be affected.';
      case 'settings_screen.delete_app_data.button_label':
        return 'Delete Now';
      case 'settings_screen.delete_app_data.alert_dialog.title':
        return 'Delete Local App Data?';
      case 'settings_screen.delete_app_data.alert_dialog.content':
        return 'This action cannot be undone. Your preferred language, theme mode and other settings will be deleted. You need to restart the app for the changes to take effect.';
      case 'settings_screen.delete_app_data.alert_dialog.abort_label':
        return 'Keep Data';
      case 'settings_screen.delete_app_data.alert_dialog.execute_label':
        return 'Delete';
      case 'settings_screen.delete_app_data.snackbar':
        return 'Data deleted. Restart the app for the changes to take effect.';
      case 'settings_screen.placeholder_label':
        return 'There are currently very few settings for this app, since it is still in Beta.\n\nPlease come back later!';
      case 'general_screen.section.input':
        return 'Wort readings';
      case 'general_screen.section.result':
        return 'Result';
      case 'general_screen.labels.og':
        return 'Original Gravity (OG)';
      case 'general_screen.labels.fg':
        return 'Final Gravity (FG)';
      case 'general_screen.labels.unit':
        return 'Unit';
      case 'general_screen.labels.abv':
        return 'Alcohol by Volume';
      case 'general_screen.labels.abw':
        return 'Alcohol by Weight';
      case 'general_screen.labels.calories':
        return 'Calories';
      case 'general_screen.labels.carbs':
        return 'Carbs';
      case 'general_screen.labels.apparent_attenuation':
        return 'Apparent Attenuation';
      case 'general_screen.labels.real_attenuation':
        return 'Real Attenuation';
      case 'general_screen.labels.original_extract':
        return 'Original Extract';
      case 'general_screen.labels.apparent_extract':
        return 'Apparent Extract';
      case 'general_screen.labels.real_extract':
        return 'Real Extract';
      case 'general_screen.units.sg':
        return 'SG';
      case 'general_screen.units.plato':
        return '°Plato';
      case 'general_screen.per_100ml':
        return 'per 100 ml';
      case 'general_screen.hint.og_plato':
        return 'e.g. 12.5';
      case 'general_screen.hint.fg_plato':
        return 'e.g. 2.4';
      case 'general_screen.hint.og_sg':
        return 'e.g. 1.050';
      case 'general_screen.hint.fg_sg':
        return 'e.g. 1.010';
      case 'general_screen.info':
        return 'Enter Original Gravity (OG) and Final Gravity (FG) to calculate ABV, attenuation and calories.';
      case 'general_screen.tabs.abv':
        return 'ABV';
      case 'general_screen.tabs.refractometer':
        return 'Refractometer';
      case 'general_screen.tabs.hydrometer':
        return 'Hydrometer';
      case 'general_screen.tabs.carbonation':
        return 'Carbonation';
      case 'refractometer_screen.fermented_wort':
        return 'Fermented wort?';
      case 'refractometer_screen.labels.og':
        return 'Original Gravity (OG)';
      case 'refractometer_screen.labels.brix':
        return 'Brix WRI';
      case 'refractometer_screen.labels.correction_factor':
        return 'Correction Factor';
      case 'refractometer_screen.labels.gravity':
        return 'Gravity';
      case 'refractometer_screen.labels.abv':
        return 'ABV';
      case 'refractometer_screen.labels.abw':
        return 'ABW';
      case 'refractometer_screen.hint.og':
        return 'e.g. 10.48';
      case 'refractometer_screen.hint.brix':
        return 'e.g. 6';
      case 'refractometer_screen.hint.correction_factor':
        return 'e.g. 1.04';
      case 'refractometer_screen.info':
        return 'Enter your refractometer Brix reading to get your gravity measurement. If the wort is fermented you also have to enter your original gravity measurement.';
      case 'hydrometer_screen.labels.measured_gravity':
        return 'Measured Gravity';
      case 'hydrometer_screen.labels.temperature':
        return 'Temperature';
      case 'hydrometer_screen.labels.calibration_temp':
        return 'Calibration Temp.';
      case 'hydrometer_screen.labels.corrected_gravity':
        return 'Gravity';
      case 'hydrometer_screen.hint.measured_plato':
        return 'e.g. 2.6';
      case 'hydrometer_screen.hint.measured_sg':
        return 'e.g. 1.010';
      case 'hydrometer_screen.hint.temperature':
        return 'e.g. 21.7';
      case 'hydrometer_screen.hint.calibration_temp':
        return '20';
      case 'hydrometer_screen.info':
        return 'Enter your measured gravity and wort temperature to get the temperature-corrected gravity. The hydrometer calibration temperature is optional.';
      case 'carbonation_screen.labels.beer_style':
        return 'Beer Style';
      case 'carbonation_screen.labels.style_range':
        return 'Carbonation range';
      case 'carbonation_screen.labels.target_co2':
        return 'Carbonation';
      case 'carbonation_screen.labels.method':
        return 'Method';
      case 'carbonation_screen.labels.bottling_volume':
        return 'Bottling Volume';
      case 'carbonation_screen.labels.keg_volume':
        return 'Keg Volume';
      case 'carbonation_screen.labels.peak_fermentation_temp':
        return 'Peak Fermentation Temp';
      case 'carbonation_screen.labels.carbonation_temp':
        return 'Carbonation Temp';
      case 'carbonation_screen.methods.bottle_sugar':
        return 'Bottle (sugar)';
      case 'carbonation_screen.methods.keg_sugar':
        return 'Keg (sugar)';
      case 'carbonation_screen.methods.keg_force':
        return 'Keg (force)';
      case 'carbonation_screen.hint.volume':
        return 'e.g. 20';
      case 'carbonation_screen.hint.fermentation_temp':
        return 'e.g. 20';
      case 'carbonation_screen.hint.carbonation_temp':
        return 'e.g. 4';
      case 'carbonation_screen.result.sugar_bottle':
        return ({required Object sugar, required Object volume, required Object temp, required Object target}) =>
            '${sugar} g table sugar in ${volume} L, fermented at max ${temp} °C, for ${target} g/L CO₂';
      case 'carbonation_screen.result.sugar_keg':
        return ({required Object sugar, required Object volume, required Object temp, required Object target}) =>
            '${sugar} g table sugar in ${volume} L keg at ${temp} °C for ${target} g/L CO₂';
      case 'carbonation_screen.result.force_pressure':
        return ({required Object bar, required Object temp, required Object target}) =>
            '${bar} bar at ${temp} °C for about 1 week to reach ${target} g/L CO₂';
      case 'carbonation_screen.result.current_co2':
        return ({required Object co2}) => 'Currently ${co2} g/L CO₂ in the beer';
      case 'carbonation_screen.info':
        return 'Pick a method and beer style. For natural carbonation with sugar, the peak fermentation temperature matters — it determines how much CO₂ is already dissolved in the beer.';
      case 'dosage_screen.section.product':
        return 'Product';
      case 'dosage_screen.section.application':
        return 'Application';
      case 'dosage_screen.section.water':
        return 'Water volume';
      case 'dosage_screen.water_hint':
        return 'e.g., 20';
      case 'dosage_screen.products.custom':
        return 'Custom';
      case 'dosage_screen.pbw_mode.cold':
        return 'Cold side';
      case 'dosage_screen.pbw_mode.hot':
        return 'Kettle / hot';
      case 'dosage_screen.custom.factor_label':
        return 'Factor (amount per litre of water)';
      case 'dosage_screen.custom.factor_hint':
        return 'e.g., 1.5';
      case 'dosage_screen.custom.unit_label':
        return 'Unit';
      case 'dosage_screen.result.label':
        return 'You need';
      case 'dosage_screen.rinse.no':
        return 'do not rinse';
      case 'dosage_screen.rinse.yes':
        return 'rinse well';
      case 'dosage_screen.contact_time.starsan':
        return '1–2 min';
      case 'dosage_screen.contact_time.saniclean':
        return '2–3 min';
      case 'dosage_screen.contact_time.pbw':
        return 'soak';
      case 'dosage_screen.contact_time.chemipro_oxi':
        return '2–5 min';
      case 'dosage_screen.contact_time.custom':
        return '—';
      default:
        return null;
    }
  }
}
