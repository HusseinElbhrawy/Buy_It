import 'package:buy_it/models/product_model.dart';
import 'package:buy_it/screens/admin/edit_product_screen.dart';
import 'package:buy_it/services/store.dart';
import 'package:buy_it/shared/components/components.dart';
import 'package:buy_it/shared/components/custom_pop_up_menu.dart';
import 'package:buy_it/shared/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

class ManagedProductScreen extends StatelessWidget {
  ManagedProductScreen({Key? key}) : super(key: key);
  static const id = 'ManagedProductScreen';
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
              return GridView.builder(
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: GestureDetector(
                    onTapUp: (details) {
                      double dx = details.globalPosition.dx;
                      double dy = details.globalPosition.dy;
                      double dx2 = MediaQuery.of(context).size.width - dx;
                      double dy2 = MediaQuery.of(context).size.height - dy;

                      showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                        items: [
                          MyPopUpMenuItem(
                            childWidget: const Text('Edit'),
                            onClick: () {
                              Navigator.pushReplacementNamed(
                                context,
                                EditProductScreen.id,
                                arguments: products[index],
                              );
                            },
                          ),
                          MyPopUpMenuItem(
                            childWidget: const Text('Delete'),
                            onClick: () {
                              store.deleteProduct(
                                productId: products[index].productId,
                              );
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                    child: BuyItItemWidget(
                      index: index,
                      products: products,
                    ),
                  ),
                ),
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.5,
                ),
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
}
