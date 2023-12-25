import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sklep_strony_internetowe/src/shared/color_themes.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String imagePath;
  final String semanticsLabel;
  final ThemeNotifier themeNotifier;

  final String heroTag;

  const CustomFloatingActionButton(
      {super.key,
      required this.onPressed,
      required this.imagePath,
      required this.semanticsLabel,
      required this.heroTag,
      required this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = themeNotifier.currentTheme;
    return FloatingActionButton(
      heroTag: heroTag,
      onPressed: onPressed,
      backgroundColor:
          currentTheme.elevatedButtonTheme.style?.backgroundColor?.resolve({}),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: SvgPicture.asset(
        imagePath,
        semanticsLabel: semanticsLabel,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
    );
  }
}
