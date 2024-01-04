import 'package:collection/collection.dart';

import 'package:sklep_strony_internetowe/src/screens/checkout.dart/cart_items.dart';

class ShoppingCart {
  List<CartItem> items = [];

  ShoppingCart({List<CartItem> items = const []})
      : items = items.toList(); // Domyślny konstruktor

  void addItem(String productName, double productPrice, int quantity) {
    var existingItem =
        items.firstWhereOrNull((item) => item.productName == productName);

    if (existingItem != null) {
      existingItem.quantity += quantity;
    } else {
      items.add(CartItem(
        productName: productName,
        productPrice: productPrice,
        quantity: quantity,
      ));
    }
  }

  double getTotalPrice() {
    return items.fold(0.0, (total, item) => total + item.getTotalPrice());
  }

  List<Map<String, dynamic>> toJson() {
    return items.map((item) => item.toJson()).toList();
  }

  factory ShoppingCart.fromJson(List<Map<String, dynamic>> json) {
    final items = json.map((item) => CartItem.fromJson(item)).toList();
    return ShoppingCart()..items = items;
  }
}
