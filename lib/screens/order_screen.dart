import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/order.dart' show Orders;
import 'package:shopping_app/screens/side_drawer.dart';

import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: ((context, index) => OrderItem(
              order: orderData.orders[index],
            )),
      ),
      drawer: const SideDrawer(),
    );
  }
}
