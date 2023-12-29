import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  static late SharedPreferences _preferences;

  static Future<SharedPreferences> init() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences;
  }

  static Future<bool> saveString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  static String? getString(String key) {
    return _preferences.getString(key);
  }

  // Adicione métodos para outros tipos de dados conforme necessário
}
