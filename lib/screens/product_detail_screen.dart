import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/poroduct_provider.dart';

class ProductDetail extends StatelessWidget {
  // final String title;
  // const ProductDetail({super.key, required this.title});

  static const routeName = '/product-detail';

  const ProductDetail({super.key});
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct = Provider.of<ProductProvider>(context, listen: false)
        .findById(productId);
    return Scaffold(
      appBar: AppBar(title: Text(loadedProduct.title)),
      body: Column(children: [
        SizedBox(
          width: double.infinity,
          height: 300,
          child: Image.network(
            loadedProduct.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '\$${loadedProduct.price}',
          style: const TextStyle(color: Colors.grey, fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(loadedProduct.description)
      ]),
    );
  }
}
