import 'package:flutter/material.dart';
import 'package:sklep_strony_internetowe/src/authenticate/register_screen.dart';
import 'package:sklep_strony_internetowe/src/authenticate/reset_password_screen.dart';

import 'package:sklep_strony_internetowe/src/shared/contact_faq_button.dart';
import 'package:sklep_strony_internetowe/src/shared/gesture_detector_text.dart';

import '../constants/input_decoration.dart';

class LoginScreen extends StatefulWidget {
  final Function? toggleView;
  const LoginScreen({Key? key, this.toggleView}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  bool? isChecked = false;
  final scrollController = ScrollController();

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
                    Container(
                      width: 205,
                      height: 47,
                      margin: const EdgeInsets.only(left: 77, right: 78),
                      child: TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Hasło'),
                        obscureText: true,
                        validator: (val) => val!.isEmpty ? 'Podaj hasło' : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                    ),
                    Container(
                      width: 156,
                      height: 42,
                      margin: const EdgeInsets.only(left: 94, right: 110),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          const Text('Zapamiętaj mnie'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(215, 55),
                        backgroundColor:
                            const Color.fromARGB(255, 195, 172, 126),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: const Text('Zaloguj się'),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetectorText(
                        text: 'Nie posiadasz konta? Zarejestruj się',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()),
                          );
                        }),
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetectorText(
                        text: 'Zapomniałeś hasła?',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ResetPasswordScreen()),
                          );
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const ContactButtonsContainer(),
      ),
    );
  }
}
