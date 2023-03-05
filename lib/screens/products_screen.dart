import 'package:flutter/material.dart';
import '../widgets/product_grid.dart';

class Products extends StatelessWidget {
  const Products({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Shoppi')),
        body: const ProductsGrid());
  }
}
