import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sklep_strony_internetowe/src/authenticate/authenticate.dart';
import 'package:sklep_strony_internetowe/src/models/user.dart' as custom_user;
import 'package:sklep_strony_internetowe/src/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<custom_user.User?>(context);

    if (user == null) {
      return const Authenticate();
    } else {
      return const HomeScreen();
    }
  }
}
