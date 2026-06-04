import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleManager {
  static const _kSelectedLanguageKey = 'selectedLanguage';

  static final ValueNotifier<Locale?> localeNotifier = ValueNotifier(null);

  static const Map<String, Locale> languageLocales = {
    'English': Locale('en'),
    'Spanish': Locale('es'),
    'French': Locale('fr'),
    'German': Locale('de'),
    'Italian': Locale('it'),
    'Arabic': Locale('ar'),
  };

  static Locale get defaultLocale => const Locale('en');

  static Locale? get currentLocale => localeNotifier.value;

  static String get currentLanguage =>
      languageLocales.entries
          .firstWhere(
            (entry) => entry.value == localeNotifier.value,
            orElse: () => const MapEntry('English', Locale('en')),
          )
          .key;

  static Locale localeForLanguage(String language) {
    return languageLocales[language] ?? defaultLocale;
  }

  static Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString(_kSelectedLanguageKey);
    final locale = savedLanguage != null
        ? localeForLanguage(savedLanguage)
        : defaultLocale;
    localeNotifier.value = locale;
    Intl.defaultLocale = locale.languageCode;
  }

  static Future<void> setLanguage(String language) async {
    final locale = localeForLanguage(language);
    if (localeNotifier.value == locale) return;

    localeNotifier.value = locale;
    Intl.defaultLocale = locale.languageCode;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kSelectedLanguageKey, language);
  }
}
