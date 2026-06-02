import 'dart:developer' as dev;

import 'package:mashmaster/helpers/pref_service.dart';
import 'package:mashmaster/i18n/generated/translations.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setLanguageFromPrefs() async {
  final Map<String, dynamic> prefMap = await retrievePrefs();
  if (prefMap['lang'] != null) {
    dev.log(
      "[App Startup] Found lang flag in SharedPreferences. Setting language to ${prefMap['lang']}.",
    );
    await LocaleSettings.setLocaleRaw(prefMap['lang']);
  } else {
    dev.log("[App Startup] No lang flag found. Using Device Locale.");

    await LocaleSettings.useDeviceLocale();
  }
}

Future<void> persistLanguage(String languageCode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("lang", languageCode);
  dev.log("Successfully persisted language");
}
