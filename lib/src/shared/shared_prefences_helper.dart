import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<void> saveCredentials({
    required String email,
    required String password,
    required bool isChecked,
    required bool isSwitched,
    required bool isDarkMode,
  }) async {
    final prefs = await SharedPreferencesHelper.prefs;
    prefs.setString('email', email);
    prefs.setString('password', password);
    prefs.setBool('isChecked', isChecked);
    prefs.setBool('isSwitched', isSwitched);
    prefs.setBool('isDarkMode', isDarkMode);
  }

  static Future<Map<String, dynamic>> loadCredentials() async {
    final prefs = await SharedPreferencesHelper.prefs;
    return {
      'email': prefs.getString('email') ?? '',
      'password': prefs.getString('password') ?? '',
      'isChecked': prefs.getBool('isChecked') ?? false,
      'isSwitched': prefs.getBool('isSwitched') ?? false,
      'isDarkMode': prefs.getBool('isDarkMode') ?? false,
    };
  }

  static Future<bool> loadIsSwitched() async {
    final prefs = await SharedPreferencesHelper.prefs;
    return prefs.getBool('isSwitched') ?? false;
  }

  static Future<void> saveDarkMode(bool isDarkMode) async {
    final prefs = await SharedPreferencesHelper.prefs;
    prefs.setBool('isDarkMode', isDarkMode);
  }

  static Future<bool> loadDarkMode() async {
    final prefs = await SharedPreferencesHelper.prefs;
    return prefs.getBool('isDarkMode') ?? false;
  }

  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
