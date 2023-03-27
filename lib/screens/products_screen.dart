import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/cart.dart';
import 'package:shopping_app/screens/cart_screen.dart';
import 'package:shopping_app/widgets/badge.dart';
import '../widgets/product_grid.dart';

enum FilterOption {
  favourites,
  all,
}

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  bool isFavourite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Shoppi'),
          actions: [
            PopupMenuButton(
              onSelected: (FilterOption selectedValue) {
                setState(() {
                  if (selectedValue == FilterOption.favourites) {
                    isFavourite = true;
                  } else {
                    isFavourite = false;
                  }
                });
              },
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: FilterOption.favourites,
                  child: Text('Favourite'),
                ),
                const PopupMenuItem(
                  value: FilterOption.all,
                  child: Text('All'),
                ),
              ],
              icon: const Icon(Icons.more_vert),
            ),
            Consumer<Cart>(
              builder: ((_, cart, child) => Badge(
                  value: cart.itemCount.toString(),
                  child: IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.of(context).pushNamed(CartScreen.routeName);
                    },
                  ))),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
            )
          ],
        ),
        body: ProductsGrid(
          isFavourite: isFavourite,
        ));
  }
}
