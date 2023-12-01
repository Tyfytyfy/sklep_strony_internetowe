import 'package:flutter/material.dart';
import 'package:sklep_strony_internetowe/src/shared/floating_button_icon.dart';
import 'package:sklep_strony_internetowe/src/shared/pop_up_window.dart';

import '../constants/contact_text_decoration.dart';

class ContactButtonsContainer extends StatelessWidget {
  const ContactButtonsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 32),
      child: Row(
        children: [
          Container(
            width: 63,
            height: 63,
            margin: const EdgeInsets.only(bottom: 29),
            child: CustomFloatingActionButton(
              onPressed: () {
                const CustomAlertDialog(
                  title: 'Kontakt',
                  content: Column(
                    children: [
                      // na kontakt
                      ContactInfoItem(
                          label: 'Adres', value: 'ul. Przykładowa 123'),
                      ContactInfoItem(
                          label: 'Email', value: 'info@example.com'),
                      ContactInfoItem(
                          label: 'Telefon', value: '+48 123 456 789'),
                    ],
                  ),
                ).show(context);
              },
              imagePath: 'assets/images/phone.svg',
              semanticsLabel: 'phone',
            ),
          ),
          const SizedBox(
            width: 170,
          ),
          Container(
            width: 63,
            height: 63,
            margin: const EdgeInsets.only(bottom: 29),
            child: CustomFloatingActionButton(
              onPressed: () {
                const CustomAlertDialog(
                  title: 'FAQ',
                  content: Column(
                    children: [
                      //na pytania
                    ],
                  ),
                ).show(context);
              },
              imagePath: 'assets/images/faq.svg',
              semanticsLabel: 'faq',
            ),
          ),
        ],
      ),
    );
  }
}
