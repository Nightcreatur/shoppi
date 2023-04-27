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
import 'package:shopping_app/screens/products_screen.dart';
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
        ChangeNotifierProxyProvider<Auth, ProductProvider>(
            create: (_) => ProductProvider(null, [], null),
            update: (context, auth, previousProducts) => ProductProvider(
                  auth.token,
                  previousProducts == null ? [] : previousProducts.items,
                  auth.userID,
                )),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (context) => Orders(null, [], null),
          update: (context, auth, previous) =>
              Orders(auth.token, previous!.orders ?? [], auth.userID),
        )
      ],
      child: Consumer<Auth>(
          builder: ((context, value, child) => MaterialApp(
                title: 'My Shope',
                theme: ThemeData(
                  fontFamily: 'Lato',
                  colorScheme:
                      ColorScheme.fromSwatch(primarySwatch: Colors.orange)
                          .copyWith(secondary: Colors.white),
                ),
                home: value.isAuth
                    ? const Products()
                    : FutureBuilder(
                        future: value.autoLogin(),
                        builder: ((context, snapshot) =>
                            snapshot.connectionState == ConnectionState.waiting
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : const AuthScreen()),
                      ),
                routes: {
                  ProductDetail.routeName: (context) => const ProductDetail(),
                  CartScreen.routeName: (context) => const CartScreen(),
                  OrderScreen.routeName: (context) => const OrderScreen(),
                  UserProductScreen.routeName: (context) =>
                      const UserProductScreen(),
                  EditProductScreen.routeName: (context) =>
                      const EditProductScreen(),
                },
              ))),
    );
  }
}
