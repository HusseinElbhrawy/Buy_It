import 'package:buy_it/models/product_model.dart';
import 'package:buy_it/services/store.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen({Key? key}) : super(key: key);
  static const id = 'EditProductScreen';
  final store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Product>>(
        future: store.getAllProducts(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          return ConditionalBuilder(
            condition: snapshot.hasData,
            builder: (BuildContext context) => ListView.separated(
              itemBuilder: (context, index) => Text(
                snapshot.data![index].productName,
                style: const TextStyle(fontSize: 25.0),
              ),
              itemCount: snapshot.data!.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
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
}
