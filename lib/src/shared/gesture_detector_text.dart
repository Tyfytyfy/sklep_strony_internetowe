import 'package:flutter/material.dart';
import 'package:sklep_strony_internetowe/src/shared/color_themes.dart';

class GestureDetectorText extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final ThemeNotifier themeNotifier;

  const GestureDetectorText({
    Key? key,
    required this.text,
    required this.onTap,
    required this.themeNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = themeNotifier.currentTheme;
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(
          decoration: TextDecoration.underline,
          decorationColor: currentTheme.textTheme.labelMedium?.decorationColor,
          color: currentTheme.textTheme.labelMedium?.color,
          fontFamily: 'Inter',
          fontSize: 12,
          letterSpacing: 0,
          fontWeight: FontWeight.normal,
          height: 1,
        ),
      ),
    );
  }
}
