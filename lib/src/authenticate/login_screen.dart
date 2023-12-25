import 'package:flutter/material.dart';
import 'package:sklep_strony_internetowe/src/authenticate/register_screen.dart';
import 'package:sklep_strony_internetowe/src/authenticate/reset_password_screen.dart';
import 'package:sklep_strony_internetowe/src/constants/error_decoration.dart';
import 'package:sklep_strony_internetowe/src/screens/home/home.dart';
import 'package:sklep_strony_internetowe/src/services/auth.dart';
import 'package:sklep_strony_internetowe/src/shared/color_themes.dart';

import 'package:sklep_strony_internetowe/src/shared/contact_faq_button.dart';
import 'package:sklep_strony_internetowe/src/shared/gesture_detector_text.dart';
import 'package:sklep_strony_internetowe/src/shared/loading.dart';
import 'package:sklep_strony_internetowe/src/shared/shared_prefences_helper.dart';

import '../constants/input_decoration.dart';

class LoginScreen extends StatefulWidget {
  final Function? toggleView;
  final ThemeNotifier themeNotifier;
  const LoginScreen({super.key, this.toggleView, required this.themeNotifier});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final scrollController = ScrollController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String email = '';
  String password = '';
  bool? isChecked = false;
  bool loading = false;
  String error = '';
  bool? isSwitched = false;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    loadSavedCredentials();
    _applyThemeMode();
  }

  void loadSavedCredentials() async {
    final credentials = await SharedPreferencesHelper.loadCredentials();
    if (mounted) {
      setState(() {
        _emailController.text = credentials['email'];
        _passwordController.text = credentials['password'];
        email = credentials['email'];
        password = credentials['password'];
        isChecked = credentials['isChecked'];
        isSwitched = credentials['isSwitched'];
        isDarkMode = credentials['isDarkMode'];
      });
      print(isDarkMode);
    }
  }

  void _applyThemeMode() async {
    bool isDarkMode = await SharedPreferencesHelper.loadDarkMode();
    widget.themeNotifier.setTheme(AppTheme.getThemeData(isDarkMode));
  }

  void saveCredentials() async {
    await SharedPreferencesHelper.saveCredentials(
        email: _emailController.text,
        password: _passwordController.text,
        isChecked: isChecked!,
        isSwitched: isSwitched!,
        isDarkMode: isDarkMode);
  }

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
                              style: currentTheme.textTheme.labelMedium,
                              controller: _emailController,
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
                              style: currentTheme.textTheme.labelMedium,
                              controller: _passwordController,
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
                          Container(
                            width: 160,
                            height: 41,
                            margin: const EdgeInsets.only(left: 94, right: 110),
                            child: Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: currentTheme.elevatedButtonTheme
                                      .style!.backgroundColor
                                      ?.resolve({}),
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
                                Text(
                                  'Zapamiętaj mnie',
                                  style: currentTheme.textTheme.labelMedium,
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => loading = true);
                                print(password);
                                print(email);
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  if (mounted) {
                                    setState(() {
                                      error = "Nieprawidłowe dane do logowania";
                                      loading = false;
                                    });
                                  }
                                } else if (result == 'notVerified') {
                                  if (mounted) {
                                    setState(() {
                                      error =
                                          "Email nie jest zweryfikowany. Sprawdź skrzynkę mailową.";
                                      loading = false;
                                    });
                                  }
                                } else {
                                  // Pomyślne logowanie, użytkownik jest zweryfikowany
                                  if (isChecked!) {
                                    saveCredentials();
                                  }
                                  if (!mounted) return;
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen(
                                              themeNotifier:
                                                  widget.themeNotifier,
                                            )),
                                  );
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
                            child: const Text('Zaloguj się',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
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
                                    builder: (context) => RegisterScreen(
                                          themeNotifier: widget.themeNotifier,
                                        )),
                              );
                            },
                            themeNotifier: widget.themeNotifier,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          GestureDetectorText(
                            text: 'Zapomniałeś hasła?',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResetPasswordScreen(
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
