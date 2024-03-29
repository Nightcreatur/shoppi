import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/poroduct_provider.dart';
import 'package:shopping_app/widgets/products_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool isFavourite;
  const ProductsGrid({
    required this.isFavourite,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context);
    final products =
        isFavourite ? productsData.favouriteItems : productsData.items;

    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: ((context, index) => ChangeNotifierProvider.value(
            value: products[index],
            // create: (c) => products[index],
            child: const ProductItem())));
    // id: products[index].id,
    // title: products[index].title,
    // imageUrl: products[index].imageUrl), )));
  }
}
