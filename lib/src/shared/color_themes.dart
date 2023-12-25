import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
        colorScheme: const ColorScheme.light(
          background: Color.fromARGB(255, 0, 91, 65),
        ),
        primaryColor: const Color.fromARGB(255, 35, 45, 63),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 35, 45, 63),
          elevation: 0.0,
          scrolledUnderElevation: 0.0,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Color.fromARGB(255, 35, 45, 63),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 0, 129, 112),
            ),
          ),
        ),
        textTheme: const TextTheme(
            titleLarge: TextStyle(
              color: Colors.white,
            ),
            titleMedium: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
            titleSmall:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            labelMedium:
                TextStyle(color: Colors.black, decorationColor: Colors.black),
            labelLarge: TextStyle(
                color: Colors.black, fontSize: 25) // email verification
            ),
        cardTheme: const CardTheme(
          color: Color.fromARGB(255, 0, 129, 112),
        ),
        switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return const Color.fromARGB(255, 0, 129, 112);
              }
              return Colors.grey;
            },
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
            filled: true,
            contentPadding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(color: Colors.black, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 0, 129, 112), width: 2),
              borderRadius: BorderRadius.circular(100),
            ),
            hintStyle: const TextStyle(color: Colors.black)));
  }

  static ThemeData darkTheme() {
    return ThemeData(
        colorScheme: const ColorScheme.light(
          background: Color.fromARGB(255, 0, 91, 65),
        ),
        primaryColor: const Color.fromARGB(255, 35, 45, 63),
        scaffoldBackgroundColor: Colors.grey[900],
        //Color.fromARGB(15, 15, 15, 1)
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 35, 45, 63),
          elevation: 0.0,
          scrolledUnderElevation: 0.0,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Color.fromARGB(255, 35, 45, 63),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 0, 129, 112),
            ),
          ),
        ),
        textTheme: const TextTheme(
            titleLarge: TextStyle(
              color: Colors.white,
            ),
            titleMedium: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold), //title w pop_up_window
            titleSmall: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold), //contact info
            labelLarge: TextStyle(
                color: Colors.white, fontSize: 25), // email verification
            labelMedium: TextStyle(
                color: Colors.white,
                decorationColor:
                    Colors.white) //to w loginScreen jest do gestureDector
            ),
        cardTheme: const CardTheme(
          color: Color.fromARGB(255, 0, 129, 112),
        ),
        switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return const Color.fromARGB(255, 0, 129, 112);
              }
              return Colors.grey;
            },
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          contentPadding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(color: Colors.white, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 0, 129, 112), width: 2),
            borderRadius: BorderRadius.circular(100),
          ),
          hintStyle: const TextStyle(color: Colors.white),
        ));
  }

  static ThemeData getThemeData(bool isDarkMode) {
    return isDarkMode ? darkTheme() : lightTheme();
  }
}

class ThemeNotifier with ChangeNotifier {
  void setTheme(ThemeData theme) {
    _currentTheme = theme;
    notifyListeners();
  }

  late ThemeData _lightTheme;
  late ThemeData _darkTheme;

  late ThemeData _currentTheme;

  ThemeNotifier() {
    _lightTheme = AppTheme.lightTheme();
    _darkTheme = AppTheme.darkTheme();
    _currentTheme = _lightTheme;
  }

  ThemeData get lightTheme => _lightTheme;
  ThemeData get darkTheme => _darkTheme;

  ThemeData get currentTheme => _currentTheme;

  bool get isDarkMode => _currentTheme == _darkTheme;

  void toggleTheme() {
    _currentTheme = _currentTheme == _lightTheme ? _darkTheme : _lightTheme;
    notifyListeners();
  }
}
