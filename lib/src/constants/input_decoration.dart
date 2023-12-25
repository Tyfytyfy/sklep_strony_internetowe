import 'package:flutter/material.dart';
import 'package:sklep_strony_internetowe/src/shared/color_themes.dart';

InputDecoration buildTextInputDecoration(ThemeNotifier themeNotifier) {
  return InputDecoration(
      fillColor: themeNotifier.currentTheme.scaffoldBackgroundColor,
      filled: true,
      contentPadding:
          const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 10),
      enabledBorder:
          themeNotifier.currentTheme.inputDecorationTheme.enabledBorder,
      focusedBorder:
          themeNotifier.currentTheme.inputDecorationTheme.focusedBorder,
      hintStyle: themeNotifier.currentTheme.inputDecorationTheme.hintStyle);
}
