import 'package:flutter/material.dart';
import 'package:shopping_app/models/cart.dart';

class OrderItem {
  final String id;
  final double price;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.price,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  final List<OrderItem> _order = [];

  List<OrderItem> get orders {
    return [..._order];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _order.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        price: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
