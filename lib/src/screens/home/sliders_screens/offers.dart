import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sklep_strony_internetowe/src/models/offer.dart';
import 'package:sklep_strony_internetowe/src/services/database.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Promocje',
            style: TextStyle(
                fontSize: 25.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromARGB(255, 195, 172, 126)),
      body: StreamBuilder<Iterable<Offer>>(
        stream: DatabaseService().offers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Brak dostępnych promocji.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Offer offer = snapshot.data!.elementAt(index);
              return _buildOfferCard(offer);
            },
          );
        },
      ),
    );
  }

  Widget _buildOfferCard(Offer offer) {
    return Card(
      color: const Color.fromARGB(240, 217, 186, 140),
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(
          offer.zdjecie,
          width: 100.0,
          height: 200.0,
          fit: BoxFit.fitWidth,
        ),
        title: Text(offer.produkt,
            style: const TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Promocja: ${(offer.promocja * 100).toInt()}%',
                style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            Text(
                'Data od: ${DateFormat('yyyy-MM-dd').format(offer.dataKoniec)}',
                style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            Text(
                'Data do: ${DateFormat('yyyy-MM-dd').format(offer.dataKoniec)}',
                style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
