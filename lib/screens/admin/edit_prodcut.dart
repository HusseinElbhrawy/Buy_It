import 'package:buy_it/models/product_model.dart';
import 'package:buy_it/services/store.dart';
import 'package:buy_it/shared/components/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen({Key? key}) : super(key: key);
  static const id = 'EditProductScreen';
  final store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: store.getAllProducts(),
        builder: (BuildContext context, snapshot) {
          return ConditionalBuilder(
            condition: snapshot.hasData,
            builder: (BuildContext context) {
              List<Product> products = [];
              addNewProductWithSnapshot(snapshot, products);
              return ListView.separated(
                itemBuilder: (context, index) => Text(
                  products[index].productName,
                  style: const TextStyle(fontSize: 25.0),
                ),
                itemCount: products.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              );
            },
            fallback: (BuildContext context) => const Center(
              child: CircularProgressIndicator(
                color: Colors.deepOrange,
              ),
            ),
          );
        },
      ),
    );
  }

  void addNewProductWithSnapshot(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      List<Product> products) {
    for (var doc in snapshot.data!.docs) {
      var data = doc.data();
      products.add(
        Product(
          productName: data[KProdcutName],
          productPrice: data[KProdcutPrice],
          productDescription: data[KProdcutDescription],
          productCategory: data[KProdcutCategory],
          productLocation: data[KProdcutLocation],
        ),
      );
    }
  }
}
