import 'package:flutter/material.dart';
import 'package:sklep_strony_internetowe/src/authenticate/login_screen.dart';
import 'package:sklep_strony_internetowe/src/authenticate/register_screen.dart';
import 'package:sklep_strony_internetowe/src/shared/color_themes.dart';

class Authenticate extends StatefulWidget {
  final ThemeNotifier themeNotifier;
  const Authenticate({super.key, required this.themeNotifier});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LoginScreen(
        toggleView: toggleView,
        themeNotifier: widget.themeNotifier,
      );
    } else {
      return RegisterScreen(
          toggleView: toggleView, themeNotifier: widget.themeNotifier);
    }
  }
}
