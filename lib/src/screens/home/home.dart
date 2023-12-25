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
import 'package:sklep_strony_internetowe/src/shared/color_themes.dart';
import 'package:sklep_strony_internetowe/src/shared/shared_prefences_helper.dart';

class HomeScreen extends StatefulWidget {
  final ThemeNotifier themeNotifier;

  const HomeScreen({super.key, required this.themeNotifier});

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
    super.initState();
    offerSlider = OfferSlider(
      const [],
      themeNotifier: widget.themeNotifier,
    );
    newProductsSlider = NewProductsSlider(
      const [],
      themeNotifier: widget.themeNotifier,
    );
    databaseService = DatabaseService();
    _updateOfferSliderData();
    _updateNewProductsSliderData();
    _applyThemeMode();
  }

  void _applyThemeMode() async {
    bool isDarkMode = await SharedPreferencesHelper.loadDarkMode();
    widget.themeNotifier.setTheme(AppTheme.getThemeData(isDarkMode));
  }

  void _updateOfferSliderData() {
    databaseService.offers.listen((offers) {
      if (mounted) {
        setState(() {
          offerSlider = OfferSlider(
            offers.toList(),
            themeNotifier: widget.themeNotifier,
          );
        });
      }
    });
  }

  void _updateNewProductsSliderData() {
    databaseService.newProducts.listen((newProducts) {
      if (mounted) {
        setState(() {
          newProductsSlider = NewProductsSlider(
            newProducts.toList(),
            themeNotifier: widget.themeNotifier,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = widget.themeNotifier.currentTheme;
    final user = Provider.of<custom_user.User?>(context);
    String? email = user?.email;
    List<String>? emailParts = email?.split('@');
    String? username = emailParts?[0];

    return Scaffold(
      backgroundColor: currentTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: currentTheme.appBarTheme.elevation,
        scrolledUnderElevation: currentTheme.appBarTheme.scrolledUnderElevation,
        backgroundColor: currentTheme.appBarTheme.backgroundColor,
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
          "Cześć, ${username ?? ''}",
          style: TextStyle(color: currentTheme.textTheme.titleLarge?.color),
        )),
      ),
      bottomNavigationBar: BottomAppBar(
        color: currentTheme.bottomAppBarTheme.color,
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
                        builder: (context) =>
                            ProfileScreen(themeNotifier: widget.themeNotifier),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.account_box,
                    color: Colors.white,
                  ),
                  label: const Text('Profil',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(50, 40),
                    backgroundColor: currentTheme
                        .elevatedButtonTheme.style?.backgroundColor
                        ?.resolve({}),
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
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(50, 40),
                    backgroundColor: currentTheme
                        .elevatedButtonTheme.style?.backgroundColor
                        ?.resolve({}),
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
                        builder: (context) =>
                            CartScreen(themeNotifier: widget.themeNotifier),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart_rounded,
                      color: Colors.white),
                  label: const Text("Koszyk",
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(50, 40),
                    backgroundColor: currentTheme
                        .elevatedButtonTheme.style?.backgroundColor
                        ?.resolve({}),
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
                  BoxDecoration(color: currentTheme.colorScheme.background),
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
                              builder: (context) => OffersScreen(
                                  themeNotifier: widget.themeNotifier),
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
                  BoxDecoration(color: currentTheme.colorScheme.background),
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
                              builder: (context) => NewProductsScreen(
                                  themeNotifier: widget.themeNotifier),
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
              height: MediaQuery.of(context).size.height - 360,
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
                      color: currentTheme.cardTheme.color,
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
