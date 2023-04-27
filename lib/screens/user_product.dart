import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/poroduct_provider.dart';
import 'package:shopping_app/screens/editing_products.dart';
import 'package:shopping_app/screens/side_drawer.dart';
import 'package:shopping_app/widgets/user_products.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({super.key});

  static const routeName = '/userProduct';

  Future<void> refreshProducts(BuildContext context) async {
    await Provider.of<ProductProvider>(context, listen: false)
        .fetchAndGetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final products = Provider.of<ProductProvider>(context);
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
      body: FutureBuilder(
        future: refreshProducts(context),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => refreshProducts(context),
                    child: Consumer<ProductProvider>(
                      builder: (context, products, _) => Padding(
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
                    ),
                  ),
      ),
    );
  }
}
