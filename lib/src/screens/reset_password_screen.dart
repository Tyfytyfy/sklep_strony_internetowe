import 'package:flutter/material.dart';

import 'package:sklep_strony_internetowe/src/shared/contact_faq_button.dart';
import 'package:sklep_strony_internetowe/src/shared/gesture_detector_text.dart';

import '../constants/input_decoration.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String email = '';
  final TextEditingController emailController = TextEditingController();
  final scrollController = ScrollController();

  void resetPassword(String email) {
    print("Resetowanie hasła");
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 214,
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: Color.fromARGB(240, 217, 186, 140),
                ),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
              const SizedBox(
                height: 71,
              ),
              Form(
                child: Column(
                  children: [
                    Container(
                      width: 205,
                      height: 47,
                      margin: const EdgeInsets.only(left: 77, right: 78),
                      child: TextFormField(
                        controller: emailController,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) => val!.isEmpty ? 'Podaj email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        resetPassword(emailController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(215, 55),
                        backgroundColor:
                            const Color.fromARGB(255, 195, 172, 126),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: const Text('Przypomnij hasło '),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetectorText(
                        text: 'Pamiętasz hasło? Zaloguj się',
                        onTap: () {
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
              const SizedBox(
                height: 140,
              ),
            ],
          ),
        ),
        bottomNavigationBar: const ContactButtonsContainer(),
      ),
    );
  }
}
