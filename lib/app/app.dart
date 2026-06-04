import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_localizations.dart';
import 'theme.dart';
import '../screens/home_screen.dart';
import '../services/locale_manager.dart';
import '../services/theme_manager.dart';

class PackageTrackerApp extends StatelessWidget {
  const PackageTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale?>(
      valueListenable: LocaleManager.localeNotifier,
      builder: (context, locale, child) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: ThemeManager.themeModeNotifier,
          builder: (context, themeMode, child) {
            return MaterialApp(
              title: 'TrackFlow',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light(),
              darkTheme: AppTheme.dark(),
              themeMode: themeMode,
              locale: locale ?? LocaleManager.defaultLocale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const [
                AppLocalizationsDelegate.instance,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                if (locale != null) return locale;
                if (deviceLocale == null) return supportedLocales.first;
                return supportedLocales.firstWhere(
                  (supportedLocale) =>
                      supportedLocale.languageCode == deviceLocale.languageCode,
                  orElse: () => supportedLocales.first,
                );
              },
              home: const HomeScreen(),
            );
          },
        );
      },
    );
  }
}

