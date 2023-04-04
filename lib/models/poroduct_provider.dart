import 'package:flutter/material.dart';
import 'package:shopping_app/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductProvider with ChangeNotifier {
  final List<Product> _item = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  Product findById(String id) {
    return _item.firstWhere((element) => element.id == id);
  }

  List<Product> get items {
    return [..._item];
  }

  List<Product> get favouriteItems {
    return _item.where((prodItem) => prodItem.isFavourite).toList();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _item.indexWhere((element) => element.id == id);
    _item[prodIndex] = newProduct;
    notifyListeners();
  }

  void deleteProduct(String id) {
    _item.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<void> addProduct(Product product) {
    final url = Uri.https(
        'flutter-shop-8f476-default-rtdb.firebaseio.com', '/products');
    return http
        .post(url,
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'price': product.price,
              'imageUrl': product.imageUrl,
              'isFavourite': product.isFavourite
            }))
        .then((value) {
      final newProduct = Product(
        id: json.decode(value.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _item.add(newProduct);
      notifyListeners();
    }).catchError((error) {
      print(error);
      throw error;
    });
  }
}
