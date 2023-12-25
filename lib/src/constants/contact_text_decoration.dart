import 'package:flutter/material.dart';
import 'package:sklep_strony_internetowe/src/shared/color_themes.dart';

class ContactInfoItem extends StatelessWidget {
  final String label;
  final String value;
  final ThemeNotifier themeNotifier;

  const ContactInfoItem({
    super.key,
    required this.label,
    required this.value,
    required this.themeNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(
              text: '$label: ',
              style: themeNotifier.currentTheme.textTheme.titleSmall,
            ),
            TextSpan(
              text: value,
              style: themeNotifier.currentTheme.textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
