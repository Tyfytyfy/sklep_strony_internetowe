import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importuj pakiet do obsługi daty
import 'package:sklep_strony_internetowe/src/models/new_products.dart'; // Importuj model nowych produktów
import 'package:sklep_strony_internetowe/src/services/database.dart';
import 'package:sklep_strony_internetowe/src/shared/color_themes.dart'; // Importuj klasę obsługującą bazę danych

class NewProductsScreen extends StatefulWidget {
  final ThemeNotifier themeNotifier;
  const NewProductsScreen({super.key, required this.themeNotifier});

  @override
  State<NewProductsScreen> createState() => _NewProductsScreenState();
}

class _NewProductsScreenState extends State<NewProductsScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = widget.themeNotifier.currentTheme;
    return Scaffold(
      backgroundColor: currentTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: currentTheme.appBarTheme.iconTheme,
        title: Text('Nowe Produkty',
            style: currentTheme.appBarTheme.titleTextStyle),
        backgroundColor: currentTheme.appBarTheme.backgroundColor,
      ),
      body: StreamBuilder<Iterable<NewProducts>>(
        stream: DatabaseService().newProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('Brak dostępnych nowych produktów.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              NewProducts newProduct = snapshot.data!.elementAt(index);
              return _buildNewProductCard(newProduct);
            },
          );
        },
      ),
    );
  }

  Widget _buildNewProductCard(NewProducts newProduct) {
    ThemeData currentTheme = widget.themeNotifier.currentTheme;
    return Card(
      color: currentTheme.cardTheme.color,
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(
          newProduct.zdjecie,
          width: 100.0,
          height: 200.0,
          fit: BoxFit.fitWidth,
        ),
        title: Text(
          newProduct.produkt,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data pojawienia się: ${DateFormat('yyyy-MM-dd').format(newProduct.dataPojawienia)}',
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
