import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sklep_strony_internetowe/src/models/offer.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:sklep_strony_internetowe/src/screens/home/sliders/flippable_card.dart';

class OfferSlider extends StatefulWidget {
  final List<Offer> offers;

  const OfferSlider(this.offers, {super.key});

  @override
  _OfferSliderState createState() => _OfferSliderState();
}

class _OfferSliderState extends State<OfferSlider> {
  int currentPage = 0;

  final PageController _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();

    startAutoPlay();
  }

  void startAutoPlay() {
    Timer.periodic(const Duration(seconds: 8), (timer) {
      if (currentPage < widget.offers.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.offers.length,
            itemBuilder: (context, index) {
              return buildItem(widget.offers[index]);
            },
            onPageChanged: (int index) {
              _currentPageNotifier.value = index;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CirclePageIndicator(
            itemCount: widget.offers.length,
            currentPageNotifier: _currentPageNotifier,
          ),
        ),
      ],
    );
  }

  Widget buildItem(Offer offer) {
    return FlippableCard(
      front: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        clipBehavior: Clip.antiAlias,
        color: const Color.fromARGB(240, 217, 186, 140),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Zdjęcie w tle
            Image.network(
              offer.zdjecie,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
      back: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        clipBehavior: Clip.antiAlias,
        color: const Color.fromARGB(240, 217, 186, 140),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Zawartość karty
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  offer.produkt,
                  style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Przecena - ${(offer.promocja * 100).toInt()}%',
                  style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Od: ${DateFormat('yyyy-MM-dd').format(offer.dataPoczatek)}',
                  style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Do: ${DateFormat('yyyy-MM-dd').format(offer.dataKoniec)}',
                  style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
