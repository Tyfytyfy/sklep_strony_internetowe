import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:sklep_strony_internetowe/src/models/new_products.dart';

import 'package:sklep_strony_internetowe/src/screens/home/sliders/flippable_card.dart';
import 'package:sklep_strony_internetowe/src/shared/color_themes.dart';

class NewProductsSlider extends StatefulWidget {
  final List<NewProducts> newProducts;
  final ThemeNotifier themeNotifier;

  const NewProductsSlider(this.newProducts,
      {super.key, required this.themeNotifier});

  @override
  _NewProductsSliderState createState() => _NewProductsSliderState();
}

class _NewProductsSliderState extends State<NewProductsSlider> {
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
      if (currentPage < widget.newProducts.length - 1) {
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
          height: 125,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.newProducts.length,
            itemBuilder: (context, index) {
              return buildItem(widget.newProducts[index]);
            },
            onPageChanged: (int index) {
              _currentPageNotifier.value = index;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CirclePageIndicator(
            itemCount: widget.newProducts.length,
            currentPageNotifier: _currentPageNotifier,
          ),
        ),
      ],
    );
  }

  Widget buildItem(NewProducts newProduct) {
    ThemeData currentTheme = widget.themeNotifier.currentTheme;
    return FlippableCard(
      front: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        clipBehavior: Clip.antiAlias,
        color: currentTheme.cardTheme.color,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              newProduct.zdjecie,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
      back: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        clipBehavior: Clip.antiAlias,
        color: currentTheme.cardTheme.color,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  newProduct.produkt,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Dostępne od: ${DateFormat('yyyy-MM-dd').format(newProduct.dataPojawienia)}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
