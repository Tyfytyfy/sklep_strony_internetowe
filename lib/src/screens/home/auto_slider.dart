import 'dart:async';
import 'package:flutter/material.dart';

class AutoSlider {
  final List<String> items;
  final PageController _pageController = PageController();

  PageController get pageController => _pageController;

  AutoSlider(this.items);

  void startAutoPlay() {
    int currentPage = 0;

    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentPage < items.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Widget build() {
    return PageView.builder(
      controller: _pageController,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return buildItem(items[index]);
      },
    );
  }

  Widget buildItem(String item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      color: const Color.fromARGB(255, 185, 160, 107),
      child: Center(
        child: Text(
          item,
          style: const TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
    );
  }
}
