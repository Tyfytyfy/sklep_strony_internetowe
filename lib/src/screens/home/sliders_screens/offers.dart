import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sklep_strony_internetowe/src/models/offer.dart';
import 'package:sklep_strony_internetowe/src/services/database.dart';
import 'package:sklep_strony_internetowe/src/shared/color_themes.dart';

class OffersScreen extends StatefulWidget {
  final ThemeNotifier themeNotifier;
  const OffersScreen({super.key, required this.themeNotifier});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = widget.themeNotifier.currentTheme;
    return Scaffold(
      backgroundColor: currentTheme.scaffoldBackgroundColor,
      appBar: AppBar(
          iconTheme: currentTheme.appBarTheme.iconTheme,
          title: Text(
            'Promocje',
            style: currentTheme.appBarTheme.titleTextStyle,
          ),
          backgroundColor: currentTheme.appBarTheme.backgroundColor),
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
    ThemeData currentTheme = widget.themeNotifier.currentTheme;
    return Card(
      color: currentTheme.cardTheme.color,
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
