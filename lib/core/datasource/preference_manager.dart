import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static final PreferenceManager _instance = PreferenceManager._internal();

  factory PreferenceManager() => _instance;

  PreferenceManager._internal();

  static late SharedPreferences _pref;

  static Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static Future<void> setData<T>(String key, T value) async {
    if (value is String) {
      await _pref.setString(key, value);
    } else if (value is int) {
      await _pref.setInt(key, value);
    } else if (value is double) {
      await _pref.setDouble(key, value);
    } else if (value is bool) {
      await _pref.setBool(key, value);
    } else if (value is List<String>) {
      await _pref.setStringList(key, value);
    } else {
      throw Exception("Unsupported type");
    }
  }

  static T? getData<T>(String key) {
    final value = _pref.get(key);

    if (value is T) {
      return value;
    }

    return null;
  }

  static  Future<void> removeKey(String key) async {
    await _pref.remove(key);
  }

  static  Future<void> clearPrefs() async {
    await _pref.clear();
  }
}
