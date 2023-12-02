import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sklep_strony_internetowe/src/models/user.dart' as custom_user;
import 'package:sklep_strony_internetowe/src/services/auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<custom_user.User?>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(user!.email ?? ""),
        actions: [
          ElevatedButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: const Icon(Icons.person),
              label: const Text('logout')),
        ],
      ),
      body: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 195, 172, 126)),
      ),
    );
  }
}
