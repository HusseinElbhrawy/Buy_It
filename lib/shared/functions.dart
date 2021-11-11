import 'package:buy_it/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'components/const.dart';

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
