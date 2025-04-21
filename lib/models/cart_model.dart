import 'package:electro_app_team/models/product_model.dart';

class CartModel {
  final String id;
  final double totalCartPrice;
  final List<CartItem> cartItems;

  CartModel({
    required this.id,
    required this.totalCartPrice,
    required this.cartItems,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['_id'],
      totalCartPrice: json['totalCartPrice']?.toDouble() ?? 0.0,
      cartItems: (json['cartItems'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
    );
  }
}

class CartItem {
  final String id;
  final int quantity;
  final ProductModel product;

  CartItem({
    required this.id,
    required this.quantity,
    required this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['_id'],
      quantity: json['quantity'],
      product: ProductModel.fromJson(json['product']),
    );
  }
}
