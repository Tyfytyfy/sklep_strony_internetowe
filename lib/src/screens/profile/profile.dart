import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sklep_strony_internetowe/src/authenticate/login_screen.dart';
import 'package:sklep_strony_internetowe/src/models/user.dart' as custom_user;
import 'package:sklep_strony_internetowe/src/services/auth.dart';
import 'package:sklep_strony_internetowe/src/settings/settings_change_password_email.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<custom_user.User?>(context);

    String? email = user?.email;
    List<String>? emailParts = email?.split('@');
    String? username = emailParts?[0];

    return Scaffold(
      appBar: AppBar(
        title: Text("Profil użytkownika ${username ?? ''}"),
        backgroundColor: const Color.fromARGB(255, 195, 172, 126),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 11,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await _auth.signOut();
                if (!mounted) return;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              icon: const Icon(Icons.logout, color: Colors.white),
              label:
                  const Text('Wyloguj', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 40),
                  backgroundColor: const Color.fromARGB(255, 185, 160, 107)),
            ),
            const SizedBox(
              height: 11,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EmailPasswwordChange()));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 40),
                    backgroundColor: const Color.fromARGB(255, 185, 160, 107)),
                child: const Text("Zmień hasło lub email",
                    style: TextStyle(color: Colors.white)))
          ],
        ),
      ),
    );
  }
}
