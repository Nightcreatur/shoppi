import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/cart.dart' show Cart;
import 'package:shopping_app/models/order.dart';

import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total', style: TextStyle(fontSize: 20)),
                  const Spacer(),
                  Text(
                    '\$${cart.totalAmount}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  OrderNow(cart: cart),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: cart.item.length,
            itemBuilder: (context, index) => CartItem(
              id: cart.item.values.toList()[index].id,
              productId: cart.item.keys.toList()[index],
              price: cart.item.values.toList()[index].price,
              quantity: cart.item.values.toList()[index].quantity,
              title: cart.item.values.toList()[index].title,
            ),
          ))
        ],
      ),
    );
  }
}

class OrderNow extends StatefulWidget {
  const OrderNow({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderNow> createState() => _OrderNowState();
}

class _OrderNowState extends State<OrderNow> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return TextButton(
      onPressed: (widget.cart.totalAmount <= 0 || isLoading)
          ? null
          : () async {
              setState(() {
                isLoading = true;
              });

              await Provider.of<Orders>(context, listen: false).addOrder(
                  widget.cart.item.values.toList(), widget.cart.totalAmount);
              setState(() {
                isLoading = false;
              });

              widget.cart.clear();
            },
      child: isLoading
          ? const CircularProgressIndicator()
          : const Text('Order Now'),
    );
  }
}
