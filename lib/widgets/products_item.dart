import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/cart.dart';
import 'package:shopping_app/screens/product_detail_screen.dart';

import '../models/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  // final String id;
  // final String title;
  // final String imageUrl;
  // const ProductItem(
  //     {super.key,
  //     required this.id,
  //     required this.title,
  // required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetail.routeName,
          arguments: product.id,
        );
      },
      child: GridTile(
        footer: GridTileBar(
            backgroundColor: Color.fromARGB(134, 34, 33, 33),
            leading: Consumer<Product>(
              builder: (context, value, child) => IconButton(
                color: Colors.orange,
                icon: Icon(product.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_border_outlined),
                onPressed: () {
                  product.toogleFavorite();
                },
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                cart.addItem(
                  product.id,
                  product.price,
                  product.title,
                );
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Added item to cart!'),
                    action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          cart.removeSingleItem(product.id);
                        }),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_basket_outlined),
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            )),
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
