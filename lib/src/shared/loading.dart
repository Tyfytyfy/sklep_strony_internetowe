import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sklep_strony_internetowe/src/shared/color_themes.dart';

class Loading extends StatelessWidget {
  final ThemeNotifier themeNotifier;
  const Loading({super.key, required this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeNotifier.currentTheme.scaffoldBackgroundColor,
      child: Center(
        child: SpinKitPouringHourGlass(
          color: (themeNotifier
              .currentTheme.elevatedButtonTheme.style?.backgroundColor!
              .resolve({}))!,
          size: 50.0,
        ),
      ),
    );
  }
}
