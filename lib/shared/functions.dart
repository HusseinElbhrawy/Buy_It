import 'package:buy_it/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/const.dart';
import 'cubit/cubit.dart';

void addNewProductWithSnapshot(
  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
  List<Product> products,
) {
  for (var doc in snapshot.data!.docs) {
    var data = doc.data();
    products.add(
      Product(
        productId: doc.id,
        productName: data[kProductName],
        productPrice: data[kProductPrice] ?? '0',
        productDescription: data[kProductDescription] ?? '',
        productCategory: data[kProductCategory] ?? '',
        productImage: data[kProductImage] ??
            'https://st.depositphotos.com/2885805/3842/v/600/depositphotos_38422667-stock-illustration-coming-soon-message-illuminated-with.jpg',
      ),
    );
  }
}

void addToCardFunction(
    Product product, BuyItCubit cubit, BuildContext context) {
  product.productQuantity = cubit.numberOfProductItems;
  bool inCart = false;
  var productInCart = cubit.allProducts;
  for (var pro in productInCart) {
    if (pro.productName == product.productName) {
      inCart = true;
    }
  }

  if (inCart) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item is already exist , it\'s Edit '),
        duration: Duration(milliseconds: 600),
      ),
    );
  } else {
    cubit.addToCart(product);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Add To Cart Successfully'),
        duration: Duration(milliseconds: 600),
      ),
    );
  }
  cubit.numberOfProductItems = 1;
}
