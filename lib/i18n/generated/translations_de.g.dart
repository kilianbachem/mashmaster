///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsDe extends Translations {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsDe({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
    : assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
      $meta = TranslationMetadata(
        locale: AppLocale.de,
        overrides: overrides ?? {},
        cardinalResolver: cardinalResolver,
        ordinalResolver: ordinalResolver,
      ),
      super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
    super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <de>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  late final TranslationsDe _root = this; // ignore: unused_field

  // Translations
  @override
  String get app_title => 'MashMaster';
  @override
  late final _TranslationsLanguageDe language = _TranslationsLanguageDe._(_root);
  @override
  late final _TranslationsNavbarDe navbar = _TranslationsNavbarDe._(_root);
  @override
  late final _TranslationsRoutesDe routes = _TranslationsRoutesDe._(_root);
  @override
  late final _TranslationsGenericDe generic = _TranslationsGenericDe._(_root);
  @override
  late final _TranslationsHomeScreenCardsDe home_screen_cards = _TranslationsHomeScreenCardsDe._(_root);
  @override
  late final _TranslationsContactScreenDe contact_screen = _TranslationsContactScreenDe._(_root);
  @override
  late final _TranslationsSettingsScreenDe settings_screen = _TranslationsSettingsScreenDe._(_root);
  @override
  late final _TranslationsGeneralScreenDe general_screen = _TranslationsGeneralScreenDe._(_root);
  @override
  late final _TranslationsRefractometerScreenDe refractometer_screen = _TranslationsRefractometerScreenDe._(_root);
  @override
  late final _TranslationsHydrometerScreenDe hydrometer_screen = _TranslationsHydrometerScreenDe._(_root);
  @override
  late final _TranslationsDosageScreenDe dosage_screen = _TranslationsDosageScreenDe._(_root);
}

// Path: language
class _TranslationsLanguageDe extends TranslationsLanguageEn {
  _TranslationsLanguageDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get label => 'Sprache';
  @override
  String get en => 'English';
  @override
  String get de => 'Deutsch';
}

// Path: navbar
class _TranslationsNavbarDe extends TranslationsNavbarEn {
  _TranslationsNavbarDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get home => 'Home';
  @override
  String get contact => 'Kontakt';
}

// Path: routes
class _TranslationsRoutesDe extends TranslationsRoutesEn {
  _TranslationsRoutesDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get main => _root.app_title;
  @override
  String get main_dosage => _root.home_screen_cards.dosage_calc.title;
  @override
  String get main_general => _root.home_screen_cards.general_calc.title;
  @override
  String get main_brew => _root.home_screen_cards.brew_calc.title;
  @override
  String get main_unit => _root.home_screen_cards.unit_calc.title;
  @override
  String get main_mash => _root.home_screen_cards.mash_calc.title;
  @override
  String get contact => 'Kontakt';
  @override
  String get settings => 'App-Einstellungen';
}

// Path: generic
class _TranslationsGenericDe extends TranslationsGenericEn {
  _TranslationsGenericDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get placeholder_label => 'Dieses Feature ist noch nicht ganz fertig.\nSchau gerne später noch einmal vorbei!';
  @override
  String get cta_label => 'Ich möchte dieses Feature schneller haben!';
}

// Path: home_screen_cards
class _TranslationsHomeScreenCardsDe extends TranslationsHomeScreenCardsEn {
  _TranslationsHomeScreenCardsDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsHomeScreenCardsDosageCalcDe dosage_calc = _TranslationsHomeScreenCardsDosageCalcDe._(_root);
  @override
  late final _TranslationsHomeScreenCardsGeneralCalcDe general_calc = _TranslationsHomeScreenCardsGeneralCalcDe._(_root);
  @override
  late final _TranslationsHomeScreenCardsBrewCalcDe brew_calc = _TranslationsHomeScreenCardsBrewCalcDe._(_root);
  @override
  late final _TranslationsHomeScreenCardsUnitCalcDe unit_calc = _TranslationsHomeScreenCardsUnitCalcDe._(_root);
  @override
  late final _TranslationsHomeScreenCardsMashCalcDe mash_calc = _TranslationsHomeScreenCardsMashCalcDe._(_root);
}

// Path: contact_screen
class _TranslationsContactScreenDe extends TranslationsContactScreenEn {
  _TranslationsContactScreenDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get label_one => 'Für Feedback, Vorschläge und Anregungen';
  @override
  late final _TranslationsContactScreenDevCardDe dev_card = _TranslationsContactScreenDevCardDe._(_root);
  @override
  late final _TranslationsContactScreenBugReportDe bug_report = _TranslationsContactScreenBugReportDe._(_root);
  @override
  String get version_label => 'Mit ♡ in Vallendar programmiert.';
}

// Path: settings_screen
class _TranslationsSettingsScreenDe extends TranslationsSettingsScreenEn {
  _TranslationsSettingsScreenDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get theme_switch => 'Dunkles Design';
  @override
  String get system_theme_switch => 'Systemdesign verwenden';
  @override
  late final _TranslationsSettingsScreenDeleteAppDataDe delete_app_data = _TranslationsSettingsScreenDeleteAppDataDe._(_root);
  @override
  String get placeholder_label =>
      'Aktuell gibt es nur wenige Einstellungen für die App, da sie noch in der Beta ist.\n\nSchau gerne später wieder vorbei!';
}

// Path: general_screen
class _TranslationsGeneralScreenDe extends TranslationsGeneralScreenEn {
  _TranslationsGeneralScreenDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsGeneralScreenSectionDe section = _TranslationsGeneralScreenSectionDe._(_root);
  @override
  late final _TranslationsGeneralScreenLabelsDe labels = _TranslationsGeneralScreenLabelsDe._(_root);
  @override
  late final _TranslationsGeneralScreenUnitsDe units = _TranslationsGeneralScreenUnitsDe._(_root);
  @override
  String get per_100ml => 'je 100 ml';
  @override
  late final _TranslationsGeneralScreenHintDe hint = _TranslationsGeneralScreenHintDe._(_root);
  @override
  String get info => 'Gib Stammwürze (OG) und Endvergärung (FG) ein, um Alkoholgehalt, Vergärungsgrad und Kalorien zu berechnen.';
  @override
  late final _TranslationsGeneralScreenTabsDe tabs = _TranslationsGeneralScreenTabsDe._(_root);
}

// Path: refractometer_screen
class _TranslationsRefractometerScreenDe extends TranslationsRefractometerScreenEn {
  _TranslationsRefractometerScreenDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get fermented_wort => 'Vergorene Würze?';
  @override
  late final _TranslationsRefractometerScreenLabelsDe labels = _TranslationsRefractometerScreenLabelsDe._(_root);
  @override
  late final _TranslationsRefractometerScreenHintDe hint = _TranslationsRefractometerScreenHintDe._(_root);
  @override
  String get info =>
      'Gib deinen Refraktometer-Brix-Wert ein, um die Gravity zu berechnen. Bei vergorener Würze musst du zusätzlich die Stammwürze angeben.';
}

// Path: hydrometer_screen
class _TranslationsHydrometerScreenDe extends TranslationsHydrometerScreenEn {
  _TranslationsHydrometerScreenDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsHydrometerScreenLabelsDe labels = _TranslationsHydrometerScreenLabelsDe._(_root);
  @override
  late final _TranslationsHydrometerScreenHintDe hint = _TranslationsHydrometerScreenHintDe._(_root);
  @override
  String get info =>
      'Gib die gemessene Dichte und die Würzetemperatur ein, um die temperaturkorrigierte Gravity zu erhalten. Die Kalibrierungstemperatur deines Hydrometers ist optional einstellbar.';
}

// Path: dosage_screen
class _TranslationsDosageScreenDe extends TranslationsDosageScreenEn {
  _TranslationsDosageScreenDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsDosageScreenSectionDe section = _TranslationsDosageScreenSectionDe._(_root);
  @override
  String get water_hint => 'z.B. 20';
  @override
  late final _TranslationsDosageScreenProductsDe products = _TranslationsDosageScreenProductsDe._(_root);
  @override
  late final _TranslationsDosageScreenPbwModeDe pbw_mode = _TranslationsDosageScreenPbwModeDe._(_root);
  @override
  late final _TranslationsDosageScreenCustomDe custom = _TranslationsDosageScreenCustomDe._(_root);
  @override
  late final _TranslationsDosageScreenResultDe result = _TranslationsDosageScreenResultDe._(_root);
  @override
  late final _TranslationsDosageScreenRinseDe rinse = _TranslationsDosageScreenRinseDe._(_root);
  @override
  late final _TranslationsDosageScreenContactTimeDe contact_time = _TranslationsDosageScreenContactTimeDe._(_root);
}

// Path: home_screen_cards.dosage_calc
class _TranslationsHomeScreenCardsDosageCalcDe extends TranslationsHomeScreenCardsDosageCalcEn {
  _TranslationsHomeScreenCardsDosageCalcDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Reinigungsmittel-Dosierer';
  @override
  String get subtitle => 'z.B. PBW, StarSan, SaniClean, ChemiPro Oxi';
}

// Path: home_screen_cards.general_calc
class _TranslationsHomeScreenCardsGeneralCalcDe extends TranslationsHomeScreenCardsGeneralCalcEn {
  _TranslationsHomeScreenCardsGeneralCalcDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Allgemeine Berechnungen';
  @override
  String get subtitle => 'Alkoholgehalt, Kalorien, Refraktometrie, Boil-Off, Hydrometer-Korrektur, Karbonisierung';
}

// Path: home_screen_cards.brew_calc
class _TranslationsHomeScreenCardsBrewCalcDe extends TranslationsHomeScreenCardsBrewCalcEn {
  _TranslationsHomeScreenCardsBrewCalcDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Brau-Umrechnungen';
  @override
  String get subtitle => 'Extraktgehalt, Bierfarbe';
}

// Path: home_screen_cards.unit_calc
class _TranslationsHomeScreenCardsUnitCalcDe extends TranslationsHomeScreenCardsUnitCalcEn {
  _TranslationsHomeScreenCardsUnitCalcDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Einheits-Umrechnungen';
  @override
  String get subtitle => 'Volumen, Gewicht, Temperatur';
}

// Path: home_screen_cards.mash_calc
class _TranslationsHomeScreenCardsMashCalcDe extends TranslationsHomeScreenCardsMashCalcEn {
  _TranslationsHomeScreenCardsMashCalcDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Maische-Berechnungen';
  @override
  String get subtitle => 'Einmaisch- und Rasttemperatur, Maischekorbkalibrierung';
}

// Path: contact_screen.dev_card
class _TranslationsContactScreenDevCardDe extends TranslationsContactScreenDevCardEn {
  _TranslationsContactScreenDevCardDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get name => '@NightmindOfficial';
  @override
  String get title => 'App-Entwickler';
}

// Path: contact_screen.bug_report
class _TranslationsContactScreenBugReportDe extends TranslationsContactScreenBugReportEn {
  _TranslationsContactScreenBugReportDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get label => 'Du möchtest einen Bug melden?';
  @override
  String get button_label => 'Bug Report abschicken';
}

// Path: settings_screen.delete_app_data
class _TranslationsSettingsScreenDeleteAppDataDe extends TranslationsSettingsScreenDeleteAppDataEn {
  _TranslationsSettingsScreenDeleteAppDataDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'App-Daten löschen';
  @override
  String get content =>
      'Diese Aktion löscht alle lokalen App-Daten (z.B. Einstellungen von Sprache und Design). Andere Daten auf dem Gerät sind nicht betroffen.';
  @override
  String get button_label => 'Jetzt löschen';
  @override
  late final _TranslationsSettingsScreenDeleteAppDataAlertDialogDe alert_dialog = _TranslationsSettingsScreenDeleteAppDataAlertDialogDe._(_root);
  @override
  String get snackbar => 'Daten gelöscht. Starte die App neu, um die Änderungen anzuwenden.';
}

// Path: general_screen.section
class _TranslationsGeneralScreenSectionDe extends TranslationsGeneralScreenSectionEn {
  _TranslationsGeneralScreenSectionDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get input => 'Würzewerte';
  @override
  String get result => 'Ergebnis';
}

// Path: general_screen.labels
class _TranslationsGeneralScreenLabelsDe extends TranslationsGeneralScreenLabelsEn {
  _TranslationsGeneralScreenLabelsDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get og => 'Stammwürze (OG)';
  @override
  String get fg => 'Endvergärung (FG)';
  @override
  String get unit => 'Einheit';
  @override
  String get abv => 'Alkoholgehalt';
  @override
  String get abw => 'Alkohol nach Gewicht';
  @override
  String get calories => 'Kalorien';
  @override
  String get carbs => 'Kohlenhydrate';
  @override
  String get apparent_attenuation => 'Scheinbarer Vergärungsgrad';
  @override
  String get real_attenuation => 'Wirklicher Vergärungsgrad';
  @override
  String get original_extract => 'Stammwürzegehalt';
  @override
  String get apparent_extract => 'Scheinbarer Restextrakt';
  @override
  String get real_extract => 'Wirklicher Restextrakt';
}

// Path: general_screen.units
class _TranslationsGeneralScreenUnitsDe extends TranslationsGeneralScreenUnitsEn {
  _TranslationsGeneralScreenUnitsDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get sg => 'SG';
  @override
  String get plato => '°Plato';
}

// Path: general_screen.hint
class _TranslationsGeneralScreenHintDe extends TranslationsGeneralScreenHintEn {
  _TranslationsGeneralScreenHintDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get og_plato => 'z.B. 12,5';
  @override
  String get fg_plato => 'z.B. 2,4';
  @override
  String get og_sg => 'z.B. 1,050';
  @override
  String get fg_sg => 'z.B. 1,010';
}

// Path: general_screen.tabs
class _TranslationsGeneralScreenTabsDe extends TranslationsGeneralScreenTabsEn {
  _TranslationsGeneralScreenTabsDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get abv => 'Alkohol';
  @override
  String get refractometer => 'Refraktometer';
  @override
  String get hydrometer => 'Hydrometer';
}

// Path: refractometer_screen.labels
class _TranslationsRefractometerScreenLabelsDe extends TranslationsRefractometerScreenLabelsEn {
  _TranslationsRefractometerScreenLabelsDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get og => 'Stammwürze (OG)';
  @override
  String get brix => 'Brix WRI';
  @override
  String get correction_factor => 'Korrekturfaktor';
  @override
  String get gravity => 'Gravity';
  @override
  String get abv => 'ABV';
  @override
  String get abw => 'ABW';
}

// Path: refractometer_screen.hint
class _TranslationsRefractometerScreenHintDe extends TranslationsRefractometerScreenHintEn {
  _TranslationsRefractometerScreenHintDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get og => 'z.B. 10,48';
  @override
  String get brix => 'z.B. 6';
  @override
  String get correction_factor => 'z.B. 1,04';
}

// Path: hydrometer_screen.labels
class _TranslationsHydrometerScreenLabelsDe extends TranslationsHydrometerScreenLabelsEn {
  _TranslationsHydrometerScreenLabelsDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get measured_gravity => 'Gemessene Dichte';
  @override
  String get temperature => 'Temperatur';
  @override
  String get calibration_temp => 'Kalibrierungs-Temp.';
  @override
  String get corrected_gravity => 'Gravity';
}

// Path: hydrometer_screen.hint
class _TranslationsHydrometerScreenHintDe extends TranslationsHydrometerScreenHintEn {
  _TranslationsHydrometerScreenHintDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get measured_plato => 'z.B. 2,6';
  @override
  String get measured_sg => 'z.B. 1,010';
  @override
  String get temperature => 'z.B. 21,7';
  @override
  String get calibration_temp => '20';
}

// Path: dosage_screen.section
class _TranslationsDosageScreenSectionDe extends TranslationsDosageScreenSectionEn {
  _TranslationsDosageScreenSectionDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get product => 'Produkt';
  @override
  String get application => 'Anwendung';
  @override
  String get water => 'Wassermenge';
}

// Path: dosage_screen.products
class _TranslationsDosageScreenProductsDe extends TranslationsDosageScreenProductsEn {
  _TranslationsDosageScreenProductsDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get custom => 'Eigener';
}

// Path: dosage_screen.pbw_mode
class _TranslationsDosageScreenPbwModeDe extends TranslationsDosageScreenPbwModeEn {
  _TranslationsDosageScreenPbwModeDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get cold => 'Kaltseite';
  @override
  String get hot => 'Kessel / heiß';
}

// Path: dosage_screen.custom
class _TranslationsDosageScreenCustomDe extends TranslationsDosageScreenCustomEn {
  _TranslationsDosageScreenCustomDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get factor_label => 'Faktor (Menge je Liter Wasser)';
  @override
  String get factor_hint => 'z.B. 1,5';
  @override
  String get unit_label => 'Einheit';
}

// Path: dosage_screen.result
class _TranslationsDosageScreenResultDe extends TranslationsDosageScreenResultEn {
  _TranslationsDosageScreenResultDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get label => 'Du brauchst';
}

// Path: dosage_screen.rinse
class _TranslationsDosageScreenRinseDe extends TranslationsDosageScreenRinseEn {
  _TranslationsDosageScreenRinseDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get no => 'nicht spülen';
  @override
  String get yes => 'gut spülen';
}

// Path: dosage_screen.contact_time
class _TranslationsDosageScreenContactTimeDe extends TranslationsDosageScreenContactTimeEn {
  _TranslationsDosageScreenContactTimeDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get starsan => '1–2 Min';
  @override
  String get saniclean => '2–3 Min';
  @override
  String get pbw => 'einweichen';
  @override
  String get chemipro_oxi => '2–5 Min';
  @override
  String get custom => '—';
}

// Path: settings_screen.delete_app_data.alert_dialog
class _TranslationsSettingsScreenDeleteAppDataAlertDialogDe extends TranslationsSettingsScreenDeleteAppDataAlertDialogEn {
  _TranslationsSettingsScreenDeleteAppDataAlertDialogDe._(TranslationsDe root) : this._root = root, super.internal(root);

  final TranslationsDe _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Lokale App-Daten löschen?';
  @override
  String get content =>
      'Diese Aktion kann nicht rückgängig gemacht werden. Deine bevorzugte Sprache, Design, und andere Einstellungen werden zurückgesetzt. Die App muss neu gestartet werden, damit die Änderungen wirksam werden.';
  @override
  String get abort_label => 'Daten behalten';
  @override
  String get execute_label => 'Löschen';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsDe {
  dynamic _flatMapFunction(String path) {
    switch (path) {
      case 'app_title':
        return 'MashMaster';
      case 'language.label':
        return 'Sprache';
      case 'language.en':
        return 'English';
      case 'language.de':
        return 'Deutsch';
      case 'navbar.home':
        return 'Home';
      case 'navbar.contact':
        return 'Kontakt';
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
        return 'Kontakt';
      case 'routes.settings':
        return 'App-Einstellungen';
      case 'generic.placeholder_label':
        return 'Dieses Feature ist noch nicht ganz fertig.\nSchau gerne später noch einmal vorbei!';
      case 'generic.cta_label':
        return 'Ich möchte dieses Feature schneller haben!';
      case 'home_screen_cards.dosage_calc.title':
        return 'Reinigungsmittel-Dosierer';
      case 'home_screen_cards.dosage_calc.subtitle':
        return 'z.B. PBW, StarSan, SaniClean, ChemiPro Oxi';
      case 'home_screen_cards.general_calc.title':
        return 'Allgemeine Berechnungen';
      case 'home_screen_cards.general_calc.subtitle':
        return 'Alkoholgehalt, Kalorien, Refraktometrie, Boil-Off, Hydrometer-Korrektur, Karbonisierung';
      case 'home_screen_cards.brew_calc.title':
        return 'Brau-Umrechnungen';
      case 'home_screen_cards.brew_calc.subtitle':
        return 'Extraktgehalt, Bierfarbe';
      case 'home_screen_cards.unit_calc.title':
        return 'Einheits-Umrechnungen';
      case 'home_screen_cards.unit_calc.subtitle':
        return 'Volumen, Gewicht, Temperatur';
      case 'home_screen_cards.mash_calc.title':
        return 'Maische-Berechnungen';
      case 'home_screen_cards.mash_calc.subtitle':
        return 'Einmaisch- und Rasttemperatur, Maischekorbkalibrierung';
      case 'contact_screen.label_one':
        return 'Für Feedback, Vorschläge und Anregungen';
      case 'contact_screen.dev_card.name':
        return '@NightmindOfficial';
      case 'contact_screen.dev_card.title':
        return 'App-Entwickler';
      case 'contact_screen.bug_report.label':
        return 'Du möchtest einen Bug melden?';
      case 'contact_screen.bug_report.button_label':
        return 'Bug Report abschicken';
      case 'contact_screen.version_label':
        return 'Mit ♡ in Vallendar programmiert.';
      case 'settings_screen.theme_switch':
        return 'Dunkles Design';
      case 'settings_screen.system_theme_switch':
        return 'Systemdesign verwenden';
      case 'settings_screen.delete_app_data.title':
        return 'App-Daten löschen';
      case 'settings_screen.delete_app_data.content':
        return 'Diese Aktion löscht alle lokalen App-Daten (z.B. Einstellungen von Sprache und Design). Andere Daten auf dem Gerät sind nicht betroffen.';
      case 'settings_screen.delete_app_data.button_label':
        return 'Jetzt löschen';
      case 'settings_screen.delete_app_data.alert_dialog.title':
        return 'Lokale App-Daten löschen?';
      case 'settings_screen.delete_app_data.alert_dialog.content':
        return 'Diese Aktion kann nicht rückgängig gemacht werden. Deine bevorzugte Sprache, Design, und andere Einstellungen werden zurückgesetzt. Die App muss neu gestartet werden, damit die Änderungen wirksam werden.';
      case 'settings_screen.delete_app_data.alert_dialog.abort_label':
        return 'Daten behalten';
      case 'settings_screen.delete_app_data.alert_dialog.execute_label':
        return 'Löschen';
      case 'settings_screen.delete_app_data.snackbar':
        return 'Daten gelöscht. Starte die App neu, um die Änderungen anzuwenden.';
      case 'settings_screen.placeholder_label':
        return 'Aktuell gibt es nur wenige Einstellungen für die App, da sie noch in der Beta ist.\n\nSchau gerne später wieder vorbei!';
      case 'general_screen.section.input':
        return 'Würzewerte';
      case 'general_screen.section.result':
        return 'Ergebnis';
      case 'general_screen.labels.og':
        return 'Stammwürze (OG)';
      case 'general_screen.labels.fg':
        return 'Endvergärung (FG)';
      case 'general_screen.labels.unit':
        return 'Einheit';
      case 'general_screen.labels.abv':
        return 'Alkoholgehalt';
      case 'general_screen.labels.abw':
        return 'Alkohol nach Gewicht';
      case 'general_screen.labels.calories':
        return 'Kalorien';
      case 'general_screen.labels.carbs':
        return 'Kohlenhydrate';
      case 'general_screen.labels.apparent_attenuation':
        return 'Scheinbarer Vergärungsgrad';
      case 'general_screen.labels.real_attenuation':
        return 'Wirklicher Vergärungsgrad';
      case 'general_screen.labels.original_extract':
        return 'Stammwürzegehalt';
      case 'general_screen.labels.apparent_extract':
        return 'Scheinbarer Restextrakt';
      case 'general_screen.labels.real_extract':
        return 'Wirklicher Restextrakt';
      case 'general_screen.units.sg':
        return 'SG';
      case 'general_screen.units.plato':
        return '°Plato';
      case 'general_screen.per_100ml':
        return 'je 100 ml';
      case 'general_screen.hint.og_plato':
        return 'z.B. 12,5';
      case 'general_screen.hint.fg_plato':
        return 'z.B. 2,4';
      case 'general_screen.hint.og_sg':
        return 'z.B. 1,050';
      case 'general_screen.hint.fg_sg':
        return 'z.B. 1,010';
      case 'general_screen.info':
        return 'Gib Stammwürze (OG) und Endvergärung (FG) ein, um Alkoholgehalt, Vergärungsgrad und Kalorien zu berechnen.';
      case 'general_screen.tabs.abv':
        return 'Alkohol';
      case 'general_screen.tabs.refractometer':
        return 'Refraktometer';
      case 'general_screen.tabs.hydrometer':
        return 'Hydrometer';
      case 'refractometer_screen.fermented_wort':
        return 'Vergorene Würze?';
      case 'refractometer_screen.labels.og':
        return 'Stammwürze (OG)';
      case 'refractometer_screen.labels.brix':
        return 'Brix WRI';
      case 'refractometer_screen.labels.correction_factor':
        return 'Korrekturfaktor';
      case 'refractometer_screen.labels.gravity':
        return 'Gravity';
      case 'refractometer_screen.labels.abv':
        return 'ABV';
      case 'refractometer_screen.labels.abw':
        return 'ABW';
      case 'refractometer_screen.hint.og':
        return 'z.B. 10,48';
      case 'refractometer_screen.hint.brix':
        return 'z.B. 6';
      case 'refractometer_screen.hint.correction_factor':
        return 'z.B. 1,04';
      case 'refractometer_screen.info':
        return 'Gib deinen Refraktometer-Brix-Wert ein, um die Gravity zu berechnen. Bei vergorener Würze musst du zusätzlich die Stammwürze angeben.';
      case 'hydrometer_screen.labels.measured_gravity':
        return 'Gemessene Dichte';
      case 'hydrometer_screen.labels.temperature':
        return 'Temperatur';
      case 'hydrometer_screen.labels.calibration_temp':
        return 'Kalibrierungs-Temp.';
      case 'hydrometer_screen.labels.corrected_gravity':
        return 'Gravity';
      case 'hydrometer_screen.hint.measured_plato':
        return 'z.B. 2,6';
      case 'hydrometer_screen.hint.measured_sg':
        return 'z.B. 1,010';
      case 'hydrometer_screen.hint.temperature':
        return 'z.B. 21,7';
      case 'hydrometer_screen.hint.calibration_temp':
        return '20';
      case 'hydrometer_screen.info':
        return 'Gib die gemessene Dichte und die Würzetemperatur ein, um die temperaturkorrigierte Gravity zu erhalten. Die Kalibrierungstemperatur deines Hydrometers ist optional einstellbar.';
      case 'dosage_screen.section.product':
        return 'Produkt';
      case 'dosage_screen.section.application':
        return 'Anwendung';
      case 'dosage_screen.section.water':
        return 'Wassermenge';
      case 'dosage_screen.water_hint':
        return 'z.B. 20';
      case 'dosage_screen.products.custom':
        return 'Eigener';
      case 'dosage_screen.pbw_mode.cold':
        return 'Kaltseite';
      case 'dosage_screen.pbw_mode.hot':
        return 'Kessel / heiß';
      case 'dosage_screen.custom.factor_label':
        return 'Faktor (Menge je Liter Wasser)';
      case 'dosage_screen.custom.factor_hint':
        return 'z.B. 1,5';
      case 'dosage_screen.custom.unit_label':
        return 'Einheit';
      case 'dosage_screen.result.label':
        return 'Du brauchst';
      case 'dosage_screen.rinse.no':
        return 'nicht spülen';
      case 'dosage_screen.rinse.yes':
        return 'gut spülen';
      case 'dosage_screen.contact_time.starsan':
        return '1–2 Min';
      case 'dosage_screen.contact_time.saniclean':
        return '2–3 Min';
      case 'dosage_screen.contact_time.pbw':
        return 'einweichen';
      case 'dosage_screen.contact_time.chemipro_oxi':
        return '2–5 Min';
      case 'dosage_screen.contact_time.custom':
        return '—';
      default:
        return null;
    }
  }
}
