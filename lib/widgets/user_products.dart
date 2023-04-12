import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/poroduct_provider.dart';
import 'package:shopping_app/screens/editing_products.dart';

class UserProductData extends StatelessWidget {
  const UserProductData(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.id});
  final String imageUrl;
  final String title;
  final String id;

  @override
  Widget build(BuildContext context) {
    final contex = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, EditProductScreen.routeName,
                    arguments: id);
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
                onPressed: () async {
                  try {
                    await Provider.of<ProductProvider>(context, listen: false)
                        .deleteProduct(id);
                  } catch (e) {
                    contex.showSnackBar(
                        const SnackBar(content: Text('Deleting failed!')));
                  }
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ))
          ],
        ),
      ),
    );
  }
}
