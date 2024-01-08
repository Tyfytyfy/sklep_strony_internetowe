import 'package:flutter/material.dart';
import 'package:sklep_strony_internetowe/src/screens/checkout.dart/cart_items.dart';
import 'package:sklep_strony_internetowe/src/screens/checkout.dart/shopping_cart.dart';
import 'package:sklep_strony_internetowe/src/shared/color_themes.dart';
import 'package:sklep_strony_internetowe/src/shared/shared_prefences_helper.dart';

class CartScreen extends StatefulWidget {
  final ThemeNotifier themeNotifier;
  final ShoppingCart shoppingCart;

  const CartScreen({
    super.key,
    required this.themeNotifier,
    required this.shoppingCart,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late ShoppingCart shoppingCart;
  @override
  void initState() {
    shoppingCart = widget.shoppingCart;
    loadCart();
    super.initState();
  }

  Future<void> loadCart() async {
    final loadedCartItems = await SharedPreferencesHelper.loadCart();
    setState(() {
      shoppingCart = ShoppingCart(items: loadedCartItems);
    });
  }

  @override
  void dispose() {
    widget.shoppingCart.items = shoppingCart.items;
    SharedPreferencesHelper.saveCart(widget.shoppingCart.items);
    super.dispose();
  }

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
        backgroundColor: currentTheme.appBarTheme.backgroundColor,
      ),
      body: Column(
        children: [
          // Dodaj ten widget do wypisania zawartości koszyka
          Expanded(
            child: ListView.builder(
              itemCount: shoppingCart.items.length,
              itemBuilder: (context, index) {
                CartItem cartItem = shoppingCart.items[index];
                return ListTile(
                  title: Text(
                    cartItem.productName,
                    style: currentTheme.textTheme.labelMedium,
                  ),
                  subtitle: Text(
                    'Cena: ${cartItem.productPrice} zł x Ilość: ${cartItem.quantity}',
                    style: currentTheme.textTheme.labelMedium,
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: currentTheme.textTheme.labelMedium?.color,
                    ),
                    onPressed: () {
                      setState(() {
                        shoppingCart.items.removeAt(index);
                        SharedPreferencesHelper.saveCart(
                            widget.shoppingCart.items);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Text(
            'Całkowita cena: ${shoppingCart.getTotalPrice()} zł',
            style: currentTheme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
