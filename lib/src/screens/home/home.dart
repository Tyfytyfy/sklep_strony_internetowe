import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sklep_strony_internetowe/src/models/user.dart' as custom_user;
import 'package:sklep_strony_internetowe/src/screens/profile/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<custom_user.User?>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(240, 217, 186, 140),
        title: Text(user!.email ?? ""),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            icon: const Icon(Icons.account_box),
            label: const Text('Profil'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 195, 172, 126),
            ),
          ),
        ],
      ),
      body: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 195, 172, 126)),
      ),
    );
  }
}
