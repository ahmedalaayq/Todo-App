import 'package:flutter/material.dart';
import 'package:todo_app/core/datasource/preference_manager.dart';
import 'package:todo_app/core/datasource/storage_key.dart';

class ThemeManager extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDark => _themeMode == ThemeMode.dark;

  Future<void> init() async {
    final result =
        PreferenceManager.getData<bool>(StorageKey.theme) ?? true;

    _themeMode = result ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _themeMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;

    await PreferenceManager.setData<bool>(
      StorageKey.theme,
      _themeMode == ThemeMode.dark,
    );

    notifyListeners();
  }

  Future<void> setTheme(ThemeMode mode) async {
    _themeMode = mode;

    await PreferenceManager.setData<bool>(
      StorageKey.theme,
      mode == ThemeMode.dark,
    );

    notifyListeners();
  }
}