// product_tile.dart
import 'package:flutter/material.dart';

import 'package:sklep_strony_internetowe/src/models/departments_products.dart';
import 'package:sklep_strony_internetowe/src/screens/checkout.dart/cart_items.dart';
import 'package:sklep_strony_internetowe/src/screens/checkout.dart/shopping_cart.dart';
import 'package:sklep_strony_internetowe/src/shared/color_themes.dart';
import 'package:sklep_strony_internetowe/src/shared/shared_prefences_helper.dart';

class ProductTile extends StatefulWidget {
  final DepartmentProduct product;
  final ThemeNotifier themeNotifier;
  final ShoppingCart shoppingCart;

  const ProductTile({
    super.key,
    required this.product,
    required this.themeNotifier,
    required this.shoppingCart,
  });

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  int quantity = 1;
  late ShoppingCart shoppingCartTemp;
  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  Future<void> loadCart() async {
    final loadedCartItems = await SharedPreferencesHelper.loadCart();
    print(loadedCartItems);
    setState(() {
      shoppingCartTemp = ShoppingCart(items: loadedCartItems);
    });
  }

  void addToCart() async {
    List<CartItem> loadedItems = await SharedPreferencesHelper.loadCart();

    bool isProductInCart = loadedItems.any((item) =>
        item.productName == widget.product.nazwa &&
        item.productPrice == widget.product.cena);

    if (!isProductInCart) {
      loadedItems.add(CartItem(
        productName: widget.product.nazwa,
        productPrice: widget.product.cena,
        quantity: quantity,
      ));

      setState(() {
        widget.shoppingCart.items = loadedItems;
      });

      SharedPreferencesHelper.saveCart(loadedItems);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${widget.product.nazwa} został dodany do koszyka'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Produkt już znajduje się w koszyku'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = widget.themeNotifier.currentTheme;
    return ExpansionTile(
      backgroundColor: currentTheme.colorScheme.background,
      title:
          Text(widget.product.nazwa, style: currentTheme.textTheme.titleSmall),
      subtitle: Text('Cena: ${widget.product.cena} zł',
          style: currentTheme.textTheme.labelMedium),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.remove,
                color: currentTheme.textTheme.labelMedium?.color,
              ),
              onPressed: decrementQuantity,
            ),
            SizedBox(
              width: 50,
              child: TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                controller: TextEditingController(text: quantity.toString()),
                readOnly: true,
                style: currentTheme.textTheme.labelMedium,
              ),
            ),
            IconButton(
              icon: Icon(Icons.add,
                  color: currentTheme.textTheme.labelMedium?.color),
              onPressed: incrementQuantity,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: addToCart,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(50, 40),
                backgroundColor: currentTheme
                    .elevatedButtonTheme.style?.backgroundColor
                    ?.resolve({}),
              ),
              child: const Text('Dodaj do koszyka',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ],
    );
  }
}
