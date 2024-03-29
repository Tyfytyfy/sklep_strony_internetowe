import 'package:flutter/material.dart';
import 'package:sklep_strony_internetowe/src/authenticate/email_verification.dart';
import 'package:sklep_strony_internetowe/src/authenticate/login_screen.dart';
import 'package:sklep_strony_internetowe/src/constants/error_decoration.dart';
import 'package:sklep_strony_internetowe/src/services/auth.dart';
import 'package:sklep_strony_internetowe/src/shared/color_themes.dart';
import 'package:sklep_strony_internetowe/src/shared/contact_faq_button.dart';
import 'package:sklep_strony_internetowe/src/shared/gesture_detector_text.dart';
import 'package:sklep_strony_internetowe/src/shared/loading.dart';

import '../constants/input_decoration.dart';

class RegisterScreen extends StatefulWidget {
  final Function? toggleView;
  final ThemeNotifier themeNotifier;
  const RegisterScreen(
      {super.key, this.toggleView, required this.themeNotifier});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final scrollController = ScrollController();

  String email = '';
  String password = '';
  String confirmPassword = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = widget.themeNotifier.currentTheme;
    return loading
        ? Loading(
            themeNotifier: widget.themeNotifier,
          )
        : Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
              backgroundColor: currentTheme.scaffoldBackgroundColor,
              body: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 214,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: currentTheme.appBarTheme.backgroundColor,
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
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            width: 205,
                            height: 47,
                            margin: const EdgeInsets.only(left: 77, right: 78),
                            child: TextFormField(
                              decoration:
                                  buildTextInputDecoration(widget.themeNotifier)
                                      .copyWith(
                                hintText: 'Email',
                              ),
                              validator: (val) =>
                                  val!.isEmpty ? 'Podaj email' : null,
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
                                  buildTextInputDecoration(widget.themeNotifier)
                                      .copyWith(
                                hintText: 'Hasło',
                              ),
                              obscureText: true,
                              validator: (val) =>
                                  val!.isEmpty ? 'Podaj hasło' : null,
                              onChanged: (val) {
                                setState(() => password = val);
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
                                  buildTextInputDecoration(widget.themeNotifier)
                                      .copyWith(
                                hintText: 'Potwierdź hasło',
                              ),
                              obscureText: true,
                              validator: (val) =>
                                  val!.isEmpty ? 'Potwierdź hasło' : null,
                              onChanged: (val) {
                                setState(() => confirmPassword = val);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 11,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        email = email, password = password);

                                if (result == null) {
                                  setState(() {
                                    error = "Podaj poprawny adres email.";
                                  });
                                } else {
                                  // Przechodzenie do ekranu weryfikacji e-maila tylko po udanej rejestracji
                                  if (!mounted) return;
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EmailVerificationScreen(
                                        themeNotifier: widget.themeNotifier,
                                      ),
                                    ),
                                  );
                                }

                                if (mounted) {
                                  setState(() {
                                    loading = false;
                                  });
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(215, 55),
                              backgroundColor: currentTheme
                                  .elevatedButtonTheme.style?.backgroundColor
                                  ?.resolve({}),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: const Text('Zarejestruj się',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          GestureDetectorText(
                            text: 'Masz już konto? Zaloguj się',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen(
                                          themeNotifier: widget.themeNotifier,
                                        )),
                              );
                            },
                            themeNotifier: widget.themeNotifier,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100)),
                            child: Text(error, style: errorSyle),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: ContactButtonsContainer(
                themeNotifier: widget.themeNotifier,
              ),
            ),
          );
  }
}
