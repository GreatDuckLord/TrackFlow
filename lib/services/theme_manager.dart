import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages the app's ThemeMode (light / dark / system).
///
/// Follows the same ValueNotifier + SharedPreferences pattern used by
/// [LocaleManager] so that the rest of the app can react to theme changes
/// via [ValueListenableBuilder].
class ThemeManager {
  static const _kThemeModeKey = 'themeMode';

  /// Notifies listeners whenever the user changes the theme.
  static final ValueNotifier<ThemeMode> themeModeNotifier =
      ValueNotifier(ThemeMode.system);

  /// Human-readable labels mapped to [ThemeMode] values.
  static const Map<String, ThemeMode> themeModes = {
    'System': ThemeMode.system,
    'Light': ThemeMode.light,
    'Dark': ThemeMode.dark,
  };

  /// The current [ThemeMode].
  static ThemeMode get currentThemeMode => themeModeNotifier.value;

  /// Returns the human-readable label for the current theme mode.
  static String get currentThemeLabel => themeModes.entries
      .firstWhere(
        (entry) => entry.value == themeModeNotifier.value,
        orElse: () => const MapEntry('System', ThemeMode.system),
      )
      .key;

  /// Call once at app start to restore the persisted preference.
  static Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_kThemeModeKey);
    if (saved != null && themeModes.containsKey(saved)) {
      themeModeNotifier.value = themeModes[saved]!;
    }
  }

  /// Persist and apply [label] (one of the keys in [themeModes]).
  static Future<void> setThemeMode(String label) async {
    final mode = themeModes[label] ?? ThemeMode.system;
    if (themeModeNotifier.value == mode) return;

    themeModeNotifier.value = mode;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kThemeModeKey, label);
  }
}
