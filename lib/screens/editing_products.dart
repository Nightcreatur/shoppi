import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/poroduct_provider.dart';
import 'package:shopping_app/models/product.dart';

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
  final form = GlobalKey<FormState>();
  var editedProduct = Product(
    id: '',
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );
  @override
  void dispose() {
    focusNode.dispose();
    descFocusNode.dispose();
    imageController.dispose();
    super.dispose();
  }

  var isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      final product = Provider.of<ProductProvider>(context, listen: false)
          .findById(productId);
      editedProduct = product;
    }
    isInit = false;
    super.didChangeDependencies();
  }

  void saveForm() {
    final isValid = form.currentState!.validate();
    if (!isValid) {
      return;
    }
    form.currentState!.save();
    Provider.of<ProductProvider>(context, listen: false)
        .addProduct(editedProduct);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(onPressed: saveForm, icon: const Icon(Icons.save))
        ],
      ),
      body: Form(
          key: form,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the title';
                  } else {
                    return null;
                  }
                },
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(focusNode);
                },
                onSaved: (newValue) {
                  editedProduct = Product(
                    id: '',
                    title: newValue!,
                    description: editedProduct.description,
                    price: editedProduct.price,
                    imageUrl: editedProduct.imageUrl,
                  );
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter number greater than 0';
                  } else {
                    return null;
                  }
                },
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(descFocusNode);
                },
                onSaved: (newValue) {
                  editedProduct = Product(
                    id: '',
                    title: editedProduct.title,
                    description: editedProduct.description,
                    price: double.parse(newValue!),
                    imageUrl: editedProduct.imageUrl,
                  );
                },
                focusNode: focusNode,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the description';
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.multiline,
                focusNode: descFocusNode,
                onSaved: (newValue) {
                  editedProduct = Product(
                    id: '',
                    title: editedProduct.title,
                    description: newValue!,
                    price: editedProduct.price,
                    imageUrl: editedProduct.imageUrl,
                  );
                },
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the Image Url';
                        }
                        if (!value.startsWith('httpp') &&
                            !value.startsWith('https')) {
                          return 'Pleaser enter a valid image address';
                        } else {
                          return null;
                        }
                      },
                      controller: imageController,
                      onFieldSubmitted: (_) => saveForm(),
                      onSaved: (newValue) {
                        editedProduct = Product(
                          id: '',
                          title: editedProduct.title,
                          description: editedProduct.description,
                          price: editedProduct.price,
                          imageUrl: newValue!,
                        );
                      },
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
