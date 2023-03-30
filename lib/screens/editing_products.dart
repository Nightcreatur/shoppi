import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});
  static const routeName = '/editProuct';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final focusNode = FocusNode();
  final descFocusNode = FocusNode();
  final imageController = TextEditingController();
  @override
  void dispose() {
    focusNode.dispose();
    descFocusNode.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Form(
          child: ListView(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Title'),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(focusNode);
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Price'),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(descFocusNode);
            },
            focusNode: focusNode,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Description'),
            maxLines: 3,
            keyboardType: TextInputType.multiline,
            focusNode: descFocusNode,
          ),
          Row(
            children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.green),
                ),
                child: imageController.text.isEmpty
                    ? const Text('Enter a URL')
                    : FittedBox(
                        child: Image.network(
                          imageController.text,
                          fit: BoxFit.contain,
                        ),
                      ),
              ),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Image Url'),
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.done,
                  controller: imageController,
                ),
              )
            ],
          )
        ],
      )),
    );
  }
}
