import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importuj pakiet do obsługi daty
import 'package:sklep_strony_internetowe/src/models/new_products.dart'; // Importuj model nowych produktów
import 'package:sklep_strony_internetowe/src/services/database.dart'; // Importuj klasę obsługującą bazę danych

class NewProductsScreen extends StatefulWidget {
  const NewProductsScreen({super.key});

  @override
  State<NewProductsScreen> createState() => _NewProductsScreenState();
}

class _NewProductsScreenState extends State<NewProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Nowe Produkty',
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 195, 172, 126),
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
    return Card(
      color: const Color.fromARGB(240, 217, 186, 140),
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
