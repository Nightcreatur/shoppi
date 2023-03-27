import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> item = {};

  int get itemCount {
    return item.length;
  }

  Map<String, CartItem> get items {
    return {...item};
  }

  double get totalAmount {
    var totalAmount = 0.0;
    item.forEach((key, value) {
      totalAmount += value.price * value.quantity;
    });
    return totalAmount;
  }

  void removeItem(String productId) {
    item.remove(productId);
    notifyListeners();
  }

  void addItem(String productId, double price, String title) {
    if (item.containsKey(productId)) {
      item.update(
          productId,
          (existingItem) => CartItem(
                id: existingItem.id,
                title: existingItem.title,
                quantity: existingItem.quantity + 1,
                price: existingItem.price,
              ));
    } else {
      item.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                quantity: 1,
                price: price,
              ));
    }
    notifyListeners();
  }

  void clear() {
    item = {};
    notifyListeners();
  }
}
