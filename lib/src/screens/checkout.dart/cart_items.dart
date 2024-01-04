class CartItem {
  final String productName;
  final double productPrice;
  int quantity;

  CartItem({
    required this.productName,
    required this.productPrice,
    required this.quantity,
  });

  double getTotalPrice() {
    return productPrice * quantity;
  }

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productName: json['productName'],
      productPrice: json['productPrice'],
      quantity: json['quantity'],
    );
  }
}
