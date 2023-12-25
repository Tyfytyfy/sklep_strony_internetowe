import 'package:flutter/material.dart';
import 'package:sklep_strony_internetowe/src/shared/color_themes.dart';

class CustomAlertDialog extends StatelessWidget {
  final ThemeNotifier themeNotifier;
  final String title;
  final Widget content;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.themeNotifier,
  });

  void show(BuildContext context) {
    ThemeData currentTheme = themeNotifier.currentTheme;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          backgroundColor: currentTheme.scaffoldBackgroundColor,
          child: SizedBox(
            width: 296,
            height: 637,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(title, style: currentTheme.textTheme.titleMedium),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: content,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        show(context);
      },
      child: const Text('Open Dialog'),
    );
  }
}
