import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  // final String title;
  // const ProductDetail({super.key, required this.title});

  static const routeName = '/product-detail';

  const ProductDetail({super.key});
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: Text('title')),
    );
  }
}
