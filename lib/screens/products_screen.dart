import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/cart.dart';
import 'package:shopping_app/models/poroduct_provider.dart';
import 'package:shopping_app/screens/cart_screen.dart';
import 'package:shopping_app/screens/side_drawer.dart';
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
  bool isLoading = false;
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<ProductProvider>(
        context,
      ).fetchAndGetProducts().then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  // @override
  // void initState() {
  //   if (isInit) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //   }
  //   Future.delayed(Duration.zero).then(
  //     (_) => Provider.of<ProductProvider>(context, listen: false)
  //         .fetchAndGetProducts()
  //         .then((value) {
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }),
  //   );
  //   isInit = false;
  //   super.initState();
  // }

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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(
              isFavourite: isFavourite,
            ),
      drawer: const SideDrawer(),
    );
  }
}
