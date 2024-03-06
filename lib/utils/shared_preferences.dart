
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static SharedPreferences? _preferences;

  static Future initSharedPrefs() async =>
      _preferences = await SharedPreferences.getInstance();

  static dynamic getSharedPreference(String key) {
    if (_preferences == null) return null;
    return _preferences!.get(key);
  }

  static Future<bool> setSharedPreference(String key, dynamic value) async {
    if (_preferences == null) return false;
    if (value is String) return await _preferences!.setString(key, value);
    if (value is int) return await _preferences!.setInt(key, value);
    if (value is bool) return await _preferences!.setBool(key, value);
    if (value is double) return await _preferences!.setDouble(key, value);
    return false;
  }

  static Future<bool> removeSharedPreference(String key) async {
    if (_preferences == null) return false;
    return await _preferences!.remove(key);
  }

  static Future<bool> clearSharedPreference() async {
    if (_preferences == null) return false;
    return await _preferences!.clear();
  }

  static Future<bool> checkSharedPreference(String key) async {
    if (_preferences == null) return false;
    return _preferences!.containsKey(key);
  }
}
