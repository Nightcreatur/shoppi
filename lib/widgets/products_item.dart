import 'package:flutter/material.dart';
import 'package:shopping_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  const ProductItem(
      {super.key,
      required this.id,
      required this.title,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetail.routeName,
          arguments: id,
        );
      },
      child: GridTile(
        footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: IconButton(
              color: Theme.of(context).primaryColor,
              icon: const Icon(Icons.favorite),
              onPressed: () {},
            ),
            trailing: const IconButton(
                onPressed: null, icon: Icon(Icons.shopping_basket)),
            title: Text(
              title,
              textAlign: TextAlign.center,
            )),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
