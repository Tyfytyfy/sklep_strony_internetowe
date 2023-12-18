import 'package:flutter/material.dart';
import 'package:sklep_strony_internetowe/src/constants/error_decoration.dart';
import 'package:sklep_strony_internetowe/src/services/auth.dart';

import 'package:sklep_strony_internetowe/src/shared/contact_faq_button.dart';
import 'package:sklep_strony_internetowe/src/shared/gesture_detector_text.dart';
import 'package:sklep_strony_internetowe/src/shared/loading.dart';

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
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Directionality(
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
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            width: 205,
                            height: 47,
                            margin: const EdgeInsets.only(left: 77, right: 78),
                            child: TextFormField(
                              controller: emailController,
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Email'),
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
                              }),
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
              bottomNavigationBar: const ContactButtonsContainer(),
            ),
          );
  }
}
