import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sklep_strony_internetowe/src/models/departments_products.dart';
import 'package:sklep_strony_internetowe/src/screens/checkout.dart/cart.dart';
import 'package:sklep_strony_internetowe/src/screens/checkout.dart/shopping_cart.dart';
import 'package:sklep_strony_internetowe/src/screens/home/departments/expand_tile.dart';
import 'package:sklep_strony_internetowe/src/services/database.dart';
import 'package:sklep_strony_internetowe/src/shared/color_themes.dart';

class DepartmentProductsScreen extends StatelessWidget {
  final ThemeNotifier themeNotifier;
  final String department;
  final String departmentArg;
  final ShoppingCart shoppingCart; // Dodajemy pole ShoppingCart

  const DepartmentProductsScreen({
    super.key,
    required this.themeNotifier,
    required this.department,
    required this.departmentArg,
    required this.shoppingCart,
  });

  @override
  Widget build(BuildContext context) {
    print('Koszyk w DepartmentProductsScreen: ${shoppingCart.items}');
    ThemeData currentTheme = themeNotifier.currentTheme;
    return Scaffold(
      backgroundColor: currentTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: currentTheme.appBarTheme.elevation,
        scrolledUnderElevation: currentTheme.appBarTheme.scrolledUnderElevation,
        backgroundColor: currentTheme.appBarTheme.backgroundColor,
        title: Text(
          'Produkty - $department',
          style: TextStyle(color: currentTheme.textTheme.titleLarge?.color),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(
                    themeNotifier: themeNotifier,
                    shoppingCart: shoppingCart,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart_rounded, color: Colors.white),
          ),
        ],
      ),
      body: FutureBuilder<List<DepartmentProduct>>(
        future: DatabaseService().fetchDepartmentProducts(departmentArg),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitPouringHourGlass(
                color: (currentTheme.elevatedButtonTheme.style!.backgroundColor!
                    .resolve({})!),
                size: 50.0,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Błąd: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'Brak dostępnych produktów dla działu $department',
                style: currentTheme.textTheme.labelMedium,
              ),
            );
          } else {
            List<DepartmentProduct> products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Container(
                  color: currentTheme.colorScheme.background,
                  padding: const EdgeInsets.all(8),
                  child: ProductTile(
                    product: products[index],
                    themeNotifier: themeNotifier,
                    shoppingCart: shoppingCart,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
