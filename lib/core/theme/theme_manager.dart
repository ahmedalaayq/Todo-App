import 'package:flutter/material.dart';
import 'package:todo_app/core/datasource/preference_manager.dart';

class ThemeManager {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.dark,
  );

  static void init() {
    final result = PreferenceManager.getData<bool>('theme') ?? true;
    themeNotifier.value = result ? .dark : .light;
  }

  static Future<void> toggleTheme() async {
    themeNotifier.value = (themeNotifier.value == .dark) ? .light : .dark;

    await PreferenceManager.setData<bool>(
      'theme',
      themeNotifier.value == .dark,
    );
  }

  static Future<void> setTheme(ThemeMode mode) async {
    themeNotifier.value = mode;
    final sharedPrefsValue = mode == .dark ? true : false;
    await PreferenceManager.setData<bool>('theme', sharedPrefsValue);
  }

  static bool get isDark => themeNotifier.value == .dark;
}
