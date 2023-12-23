import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sklep_strony_internetowe/src/models/user.dart' as custom_user;
import 'package:sklep_strony_internetowe/src/screens/checkout.dart/cart.dart';

import 'package:sklep_strony_internetowe/src/screens/home/barcode.dart';
import 'package:sklep_strony_internetowe/src/screens/home/sliders/new_products_slider.dart';

import 'package:sklep_strony_internetowe/src/screens/home/sliders/offer_slider.dart';
import 'package:sklep_strony_internetowe/src/screens/home/sliders_screens/new_products_screen.dart';
import 'package:sklep_strony_internetowe/src/screens/home/sliders_screens/offers.dart';
import 'package:sklep_strony_internetowe/src/screens/profile/profile.dart';
import 'package:sklep_strony_internetowe/src/services/database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late OfferSlider offerSlider;
  late NewProductsSlider newProductsSlider;
  late DatabaseService databaseService;
  final List<String> departments = [
    'Elektronika',
    'Moda',
    'Książki',
    'Sport',
    // Dodaj dowolne inne działy, które chcesz wyświetlić
  ];

  @override
  void initState() {
    offerSlider = const OfferSlider([]);
    newProductsSlider = const NewProductsSlider([]);

    databaseService = DatabaseService();
    _updateOfferSliderData();
    _updateNewProductsSliderData();

    super.initState();
  }

  void _updateOfferSliderData() {
    databaseService.offers.listen((offers) {
      setState(() {
        offerSlider = OfferSlider(offers.toList());
      });
    });
  }

  void _updateNewProductsSliderData() {
    databaseService.newProducts.listen((newProducts) {
      setState(() {
        newProductsSlider = NewProductsSlider(newProducts.toList());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<custom_user.User?>(context);
    String? email = user?.email;
    List<String>? emailParts = email?.split('@');
    String? username = emailParts?[0];

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
              FittedBox(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.account_box,
                    color: Colors.white,
                  ),
                  label: const Text('Profil',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(50, 40),
                    backgroundColor: const Color.fromARGB(255, 185, 160, 107),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              FittedBox(
                child: ElevatedButton.icon(
                  onPressed: () {
                    PopupBarcode.showBarcodePopup(context, user?.uid);
                  },
                  icon: const Icon(CupertinoIcons.barcode,
                      size: 30, color: Colors.white),
                  label: const Text("Karta klienta",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(50, 40),
                    backgroundColor: const Color.fromARGB(255, 185, 160, 107),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              FittedBox(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart_rounded,
                      color: Colors.white),
                  label: const Text("Koszyk",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(50, 40),
                    backgroundColor: const Color.fromARGB(255, 185, 160, 107),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 43, 94, 60)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Promocje',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OffersScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 175, child: offerSlider),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 43, 94, 60)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Nowości',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NewProductsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 150,
                    child: newProductsSlider,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
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
                      color: const Color.fromARGB(240, 217, 186,
                          140), // Tutaj można dostosować kolor kafelka
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
    );
  }
}
