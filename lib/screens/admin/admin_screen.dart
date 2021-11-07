import 'package:flutter/material.dart';

import 'add_product.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);
  static const id = 'AdminScreen';
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
        ],
      ),
      body: const Center(
        child: Text('Admin Screen'),
      ),
    );
  }
}
