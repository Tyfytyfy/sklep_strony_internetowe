import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sklep_strony_internetowe/src/models/user.dart' as custom_user;
import 'package:sklep_strony_internetowe/src/screens/checkout.dart/cart.dart';
import 'package:sklep_strony_internetowe/src/screens/home/auto_slider.dart';
import 'package:sklep_strony_internetowe/src/screens/home/barcode.dart';
import 'package:sklep_strony_internetowe/src/screens/profile/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> items1 = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  final List<String> items2 = ['Item A', 'Item B', 'Item C', 'Item D'];

  late AutoSlider autoSlider1;
  late AutoSlider autoSlider2;

  final List<String> departments = [
    'Elektronika',
    'Moda',
    'Książki',
    'Sport',
    // Dodaj dowolne inne działy, które chcesz wyświetlić
  ];

  @override
  void initState() {
    autoSlider1 = AutoSlider(items1);
    autoSlider2 = AutoSlider(items2);
    autoSlider1.startAutoPlay();
    autoSlider2.startAutoPlay();
    if (autoSlider1.pageController.hasClients) {
      autoSlider1.pageController.jumpToPage(0);
    }
    if (autoSlider2.pageController.hasClients) {
      autoSlider2.pageController.jumpToPage(0);
    }

    super.initState();
  }

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
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.account_box),
                  label: const Text('Profil'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 185, 160, 107),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    PopupBarcode.showBarcodePopup(context, user?.uid);
                  },
                  icon: const Icon(CupertinoIcons.barcode, size: 30),
                  label: const Text("Karta klienta"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 185, 160, 107),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart_rounded),
                  label: const Text("Koszyk"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 185, 160, 107),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(240, 217, 186, 140)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 150,
                child: autoSlider1.build(),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 150,
                child: autoSlider2.build(),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: MediaQuery.of(context).size.height -
                    360, // Dostosuj wysokość do potrzeb
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: departments.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Tutaj dodaj akcję, która ma być wykonana po kliknięciu na kafelek
                        // Możesz użyć Navigator do przeniesienia użytkownika na nową stronę
                        // np. Navigator.push(context, MaterialPageRoute(builder: (context) => NowaStrona()));
                      },
                      child: Card(
                        margin: const EdgeInsets.all(8.0),
                        color: const Color.fromARGB(255, 185, 160,
                            107), // Tutaj można dostosować kolor kafelka
                        child: Center(
                          child: Text(
                            departments[index],
                            style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
