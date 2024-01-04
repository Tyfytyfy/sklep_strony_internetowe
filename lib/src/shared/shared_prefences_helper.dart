import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sklep_strony_internetowe/src/screens/checkout.dart/cart_items.dart';

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

  static const String _keyCart = 'cart';

  static Future<void> saveCart(List<CartItem> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedItems = cartItems.map((item) => item.toJson()).toList();
    prefs.setString(_keyCart, jsonEncode(encodedItems));
  }

  static Future<List<CartItem>> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartJson = prefs.getString(_keyCart);

    if (cartJson != null) {
      final List<dynamic> decodedItems = jsonDecode(cartJson);
      final cartItems =
          decodedItems.map((item) => CartItem.fromJson(item)).toList();
      return cartItems;
    } else {
      print("No cart data found.");
      return [];
    }
  }

  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
