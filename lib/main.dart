import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/auth.dart';
import 'package:shopping_app/models/cart.dart';
import 'package:shopping_app/models/order.dart';
import 'package:shopping_app/models/poroduct_provider.dart';
import 'package:shopping_app/screens/auth_screen.dart';
import 'package:shopping_app/screens/cart_screen.dart';
import 'package:shopping_app/screens/editing_products.dart';
import 'package:shopping_app/screens/order_screen.dart';
import 'package:shopping_app/screens/product_detail_screen.dart';
import 'package:shopping_app/screens/user_product.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => Auth()),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        )
      ],
      child: MaterialApp(
        title: 'My Shope',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange)
              .copyWith(secondary: Colors.white),
        ),
        home: const AuthScreen(),
        routes: {
          ProductDetail.routeName: (context) => const ProductDetail(),
          CartScreen.routeName: (context) => const CartScreen(),
          OrderScreen.routeName: (context) => const OrderScreen(),
          UserProductScreen.routeName: (context) => const UserProductScreen(),
          EditProductScreen.routeName: (context) => const EditProductScreen(),
        },
      ),
    );
  }
}
