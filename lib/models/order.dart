import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_app/models/cart.dart';
import 'package:http/http.dart' as http;

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
  List<OrderItem>? _order = [];

  List<OrderItem>? get orders {
    return [..._order!];
  }

  String? authToken;
  String? userId;
  Orders(this.authToken, this._order, this.userId);

  Future<void> fetchOrderData() async {
    final url = Uri.https(
      'flutter-shop-8f476-default-rtdb.firebaseio.com',
      '/orders/$userId.json?auth=$authToken',
    );

    // var queryParameters = {'auth': authToken};
    // if (filterByUser) {
    //   queryParameters.addAll({'orderBy': 'creatorId', 'equalTo': userId});
    // }

    // var url = Uri.https(
    //   'flutter-shop-8f476-default-rtdb.firebaseio.com',
    //   '/products.json',
    //   queryParameters,
    // );
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>?;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          price: orderData['amount'],
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItem(
                  id: item['id'],
                  title: item['title'],
                  quantity: item['quantity'],
                  price: item['price']))
              .toList(),
          dateTime: DateTime.parse(orderData['dateTime']),
        ),
      );
    });
    _order = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.https(
      'flutter-shop-8f476-default-rtdb.firebaseio.com',
      '/orders/$userId.json?auth=$authToken',
    );
    final timeStamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  })
              .toList(),
        }));

    _order!.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        price: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
