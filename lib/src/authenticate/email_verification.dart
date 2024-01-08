import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sklep_strony_internetowe/src/authenticate/register_screen.dart';
import 'package:sklep_strony_internetowe/src/models/user.dart' as custom_user;
import 'package:sklep_strony_internetowe/src/screens/home/home.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sklep_strony_internetowe/src/shared/color_themes.dart';

class EmailVerificationScreen extends StatefulWidget {
  final ThemeNotifier themeNotifier;
  const EmailVerificationScreen({super.key, required this.themeNotifier});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  Future<void> checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      if (mounted) {
        // Tutaj możesz obsłużyć sytuację, gdy nie ma zalogowanego użytkownika
        // Tu możesz pokazać Snackbar lub inny komunikat użytkownikowi
      }
      return;
    }

    await currentUser.reload();

    bool isEmailVerified = currentUser.emailVerified;

    if (mounted) {
      setState(() {
        isEmailVerified = isEmailVerified;
      });
    }

    if (isEmailVerified && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            themeNotifier: widget.themeNotifier,
          ),
        ),
      );

      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<custom_user.User?>(context);
    ThemeData currentTheme = widget.themeNotifier.currentTheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: currentTheme.scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 35),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  'Sprawdź swoją \n skrzynkę mailową',
                  textAlign: TextAlign.center,
                  style: currentTheme.textTheme.labelLarge,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: currentTheme.textTheme.labelLarge,
                      children: [
                        const TextSpan(
                          text: 'Wysłaliśmy do Ciebie e-mail na ',
                        ),
                        if (user?.email != null)
                          TextSpan(
                              text: user?.email,
                              style: currentTheme.textTheme.titleMedium)
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: SpinKitPianoWave(
                  color: (currentTheme
                      .elevatedButtonTheme.style?.backgroundColor
                      ?.resolve({}))!,
                  size: 60.0,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Center(
                  child: Text(
                    'Weryfikacja e-maila....',
                    textAlign: TextAlign.center,
                    style: currentTheme.textTheme.labelLarge,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ElevatedButton(
                  onPressed: () {
                    try {
                      FirebaseAuth.instance.currentUser
                          ?.sendEmailVerification();
                    } catch (e) {
                      debugPrint('$e');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 55),
                    backgroundColor: currentTheme
                        .elevatedButtonTheme.style?.backgroundColor
                        ?.resolve({}),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: const Text('Wyślij ponownie',
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                          color: Colors.white)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen(
                                themeNotifier: widget.themeNotifier,
                              )),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 55),
                    backgroundColor: currentTheme
                        .elevatedButtonTheme.style?.backgroundColor
                        ?.resolve({}),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: const Text('Wróć do ekranu rejestracji',
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                          color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
