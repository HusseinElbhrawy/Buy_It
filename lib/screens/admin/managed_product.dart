import 'package:buy_it/models/product_model.dart';
import 'package:buy_it/services/store.dart';
import 'package:buy_it/shared/components/components.dart';
import 'package:buy_it/shared/components/const.dart';
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
                  child: BuyItItemWidget(
                    index: index,
                    products: products,
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

void addNewProductWithSnapshot(
  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
  List<Product> products,
) {
  for (var doc in snapshot.data!.docs) {
    var data = doc.data();
    products.add(
      Product(
        productId: doc.id,
        productName: data[KProdcutName],
        productPrice: data[KProdcutPrice] ?? '0',
        productDescription: data[KProdcutDescription] ?? '',
        productCategory: data[KProdcutCategory] ?? '',
        productImage: data[KProdcutImage] ??
            'https://st.depositphotos.com/2885805/3842/v/600/depositphotos_38422667-stock-illustration-coming-soon-message-illuminated-with.jpg',
      ),
    );
  }
}

class MyPopUpMenuItem<T> extends PopupMenuItem<T> {
  final Widget childWidget;
  final Function onClick;
  MyPopUpMenuItem({Key? key, required this.childWidget, required this.onClick})
      : super(key: key, child: childWidget, onTap: () => onClick());

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopUpMenuItemState();
  }
}

class MyPopUpMenuItemState<T, PopMenuItem>
    extends PopupMenuItemState<T, MyPopUpMenuItem<T>> {
  @override
  void handleTap() {
    widget.onClick();
  }
}
