import 'package:flutter/material.dart';
import 'package:sklep_strony_internetowe/src/shared/color_themes.dart';
import 'package:sklep_strony_internetowe/src/shared/floating_button_icon.dart';
import 'package:sklep_strony_internetowe/src/shared/pop_up_window.dart';

import '../constants/contact_text_decoration.dart';

class ContactButtonsContainer extends StatelessWidget {
  final ThemeNotifier themeNotifier;
  const ContactButtonsContainer({super.key, required this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 63,
            height: 63,
            margin: const EdgeInsets.only(bottom: 29),
            child: CustomFloatingActionButton(
              onPressed: () {
                CustomAlertDialog(
                  title: 'Kontakt',
                  content: Column(
                    children: [
                      // na kontakt
                      ContactInfoItem(
                        label: 'Adres',
                        value: 'ul. Przykładowa 123',
                        themeNotifier: themeNotifier,
                      ),
                      ContactInfoItem(
                          label: 'Email',
                          value: 'info@example.com',
                          themeNotifier: themeNotifier),
                      ContactInfoItem(
                          label: 'Telefon',
                          value: '+48 123 456 789',
                          themeNotifier: themeNotifier),
                    ],
                  ),
                  themeNotifier: themeNotifier,
                ).show(context);
              },
              imagePath: 'assets/images/phone.svg',
              semanticsLabel: 'phone',
              heroTag: 'phone',
              themeNotifier: themeNotifier,
            ),
          ),
          Container(
            width: 63,
            height: 63,
            margin: const EdgeInsets.only(bottom: 29),
            child: CustomFloatingActionButton(
              onPressed: () {
                CustomAlertDialog(
                  title: 'FAQ',
                  content: const Column(
                    children: [
                      //na pytania
                    ],
                  ),
                  themeNotifier: themeNotifier,
                ).show(context);
              },
              imagePath: 'assets/images/faq.svg',
              semanticsLabel: 'faq',
              heroTag: 'faq',
              themeNotifier: themeNotifier,
            ),
          ),
        ],
      ),
    );
  }
}
