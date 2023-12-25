import 'package:flutter/material.dart';
import 'package:sklep_strony_internetowe/src/shared/color_themes.dart';

class CartScreen extends StatefulWidget {
  final ThemeNotifier themeNotifier;
  const CartScreen({super.key, required this.themeNotifier});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = widget.themeNotifier.currentTheme;
    return Scaffold(
      backgroundColor: currentTheme.scaffoldBackgroundColor,
      appBar: AppBar(
          title: Text(
            "Twój koszyk",
            style: currentTheme.appBarTheme.titleTextStyle,
          ),
          iconTheme: currentTheme.appBarTheme.iconTheme,
          backgroundColor: currentTheme.appBarTheme.backgroundColor),
      body: Container(),
    );
  }
}
