import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sklep_strony_internetowe/src/models/user.dart' as custom_user;
import 'package:sklep_strony_internetowe/src/screens/home/barcode.dart';
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
    String? email = user?.email;
    List<String>? emailParts = email?.split('@');
    String? username = emailParts?[0];
    print(user?.email);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 195, 172, 126),
        title: Center(child: Text("Cześć, ${username ?? ''}")),
      ),
      bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(255, 195, 172, 126),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()),
                    );
                  },
                  icon: const Icon(Icons.account_box),
                  label: const Text('Profil'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 185, 160, 107),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    PopupBarcode.showBarcodePopup(context, user?.uid);
                  },
                  icon: const Icon(
                      Icons.barcode_reader), // zmienić na ikonkę barcode
                  label: const Text(""),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 185, 160, 107),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_cart_rounded),
                  label: const Text("Koszyk"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 185, 160, 107),
                  ),
                )
              ],
            ),
          )),
      body: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(240, 217, 186, 140)),
      ),
    );
  }
}
