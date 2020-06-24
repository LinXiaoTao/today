import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';

/// 使用 sp 实现简单存储

class SimpleStorage {
  SimpleStorage._();

  static Future<String> getString(String key) {
    return SharedPreferences.getInstance().then((prefs) {
      String value = prefs.getString(key);
      if (value == null) value = "";
      return value;
    }).catchError((error) {
      debugPrint(error.toString());
      return "";
    });
  }

  static Future<bool> putString(String key, String value) {
    return SharedPreferences.getInstance().then((prefs) {
      return prefs.setString(key, value);
    });
  }
}
