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
              return GridView.builder(
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadiusDirectional.all(Radius.circular(
                        15.0,
                      )),
                    ),
                    child: GestureDetector(
                      onTapUp: (details) {
                        var dx = details.globalPosition.dx;
                        var dy = details.globalPosition.dy;
                        var width = MediaQuery.of(context).size.width;
                        var height = MediaQuery.of(context).size.height;
                        showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(
                              dx, dy, width - dx, height - dy),
                          items: [
                            const PopupMenuItem(
                              child: Text('Edit'),
                            ),
                            const PopupMenuItem(
                              child: Text('Delete'),
                            ),
                          ],
                        );
                      },
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(
                              products[index].productLocation,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Opacity(
                              opacity: .5,
                              child: Container(
                                color: Colors.white,
                                height: 60.0,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        products[index].productName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Jannah',
                                        ),
                                      ),
                                      Text(
                                        "\$ ${products[index].productPrice}",
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
