import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sklep_strony_internetowe/src/authenticate/authenticate.dart';
import 'package:sklep_strony_internetowe/src/authenticate/email_verification.dart';
import 'package:sklep_strony_internetowe/src/models/user.dart' as custom_user;
import 'package:sklep_strony_internetowe/src/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<custom_user.User?>(context);
    FirebaseAuth auth = FirebaseAuth.instance;
    User? firebaseUser = auth.currentUser;

    if (user == null) {
      return const Authenticate();
    } else {
      if (firebaseUser!.emailVerified) {
        return const HomeScreen();
      } else {
        return const EmailVerificationScreen();
      }
    }
  }
}
