import 'package:flutter/material.dart';
import 'package:sklep_strony_internetowe/src/services/auth.dart';
import 'package:sklep_strony_internetowe/src/shared/contact_faq_button.dart';
import 'package:sklep_strony_internetowe/src/shared/gesture_detector_text.dart';
import 'package:sklep_strony_internetowe/src/shared/loading.dart';

import '../constants/input_decoration.dart';

class RegisterScreen extends StatefulWidget {
  final Function? toggleView;
  const RegisterScreen({Key? key, this.toggleView}) : super(key: key);

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
                          Container(
                            width: 205,
                            height: 47,
                            margin: const EdgeInsets.only(left: 77, right: 78),
                            child: TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Hasło'),
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
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Potwierdź hasło'),
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
                                    error = "please daj poprawny email.";
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
                            child: const Text('Zarejestruj się'),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          GestureDetectorText(
                              text: 'Masz już konto? Zaloguj się',
                              onTap: () {
                                widget.toggleView!();
                              }),
                          const SizedBox(height: 8),
                          Text(
                            error,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 14),
                          )
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
