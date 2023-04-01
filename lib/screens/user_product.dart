import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/poroduct_provider.dart';
import 'package:shopping_app/screens/editing_products.dart';
import 'package:shopping_app/screens/side_drawer.dart';
import 'package:shopping_app/widgets/user_products.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({super.key});

  static const routeName = '/userProduct';

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const SideDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: ((context, index) => Column(
                children: [
                  UserProductData(
                      id: products.items[index].id,
                      imageUrl: products.items[index].imageUrl,
                      title: products.items[index].title),
                  const Divider(),
                ],
              )),
          itemCount: products.items.length,
        ),
      ),
    );
  }
}
