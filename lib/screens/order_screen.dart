import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/order.dart' show Orders;
import 'package:shopping_app/screens/side_drawer.dart';

import '../widgets/order_item.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  static const routeName = '/orders';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchOrderData();
      setState(() {
        isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: orderData.orders!.length,
              itemBuilder: ((context, index) => OrderItem(
                    order: orderData.orders![index],
                  )),
            ),
      drawer: const SideDrawer(),
    );
  }
}
