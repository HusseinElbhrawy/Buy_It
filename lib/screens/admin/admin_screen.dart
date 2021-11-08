import 'package:buy_it/models/product_model.dart';
import 'package:buy_it/services/store.dart';
import 'package:flutter/material.dart';

import 'add_product.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);
  static const id = 'AdminScreen';
  static var store = Store();
  static List<Product> products = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProductScreen.id);
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () async {
                products = await store.getAllProducts();
                print(products[0].productDescription);
              },
              icon: const Icon(Icons.eleven_mp)),
        ],
      ),
      body: const Center(
        child: Text('Admin Screen'),
      ),
    );
  }
}
