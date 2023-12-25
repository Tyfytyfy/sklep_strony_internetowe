import 'package:flutter/material.dart';
import 'package:sklep_strony_internetowe/src/constants/error_decoration.dart';
import 'package:sklep_strony_internetowe/src/services/auth.dart';
import 'package:sklep_strony_internetowe/src/shared/color_themes.dart';

import 'package:sklep_strony_internetowe/src/shared/contact_faq_button.dart';
import 'package:sklep_strony_internetowe/src/shared/gesture_detector_text.dart';
import 'package:sklep_strony_internetowe/src/shared/loading.dart';

import '../constants/input_decoration.dart';

class ResetPasswordScreen extends StatefulWidget {
  final ThemeNotifier themeNotifier;
  const ResetPasswordScreen({super.key, required this.themeNotifier});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String email = '';
  final TextEditingController emailController = TextEditingController();
  final scrollController = ScrollController();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String error = '';

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
                              controller: emailController,
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
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => loading = true);

                                dynamic result =
                                    await _auth.resetPassword(email, context);
                                if (result == true) {
                                  // Powiadomienie o sukcesie
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'E-mail do resetowania hasła został wysłany.'),
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                                } else {
                                  // Obsługa błędu
                                  setState(() {
                                    error = "Nieprawidłowy email";
                                  });
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
                            child: const Text('Przypomnij hasło ',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          GestureDetectorText(
                            text: 'Pamiętasz hasło? Zaloguj się',
                            onTap: () {
                              Navigator.pop(context);
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
                    const SizedBox(
                      height: 140,
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
