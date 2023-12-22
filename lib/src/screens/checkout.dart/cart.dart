import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Twój koszyk"),
          backgroundColor: const Color.fromARGB(255, 195, 172, 126)),
      body: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(240, 217, 186, 140)),
      ),
    );
  }
}
