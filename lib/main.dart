import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/Provider/poroduct_provider.dart';
import 'package:shopping_app/screens/product_detail_screen.dart';
import 'package:shopping_app/screens/products_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        title: 'My Shope',
        theme: ThemeData(primarySwatch: Colors.orange, fontFamily: 'Lato'),
        home: const Products(),
        routes: {ProductDetail.routeName: (context) => const ProductDetail()},
      ),
    );
  }
}
