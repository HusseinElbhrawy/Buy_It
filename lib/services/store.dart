import 'package:buy_it/models/product_model.dart';
import 'package:buy_it/shared/components/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  addProduct(Product product) async {
    return firebaseFirestore.collection(KProdcutCollection).add({
      KProdcutName: product.productName,
      KProdcutCategory: product.productCategory,
      KProdcutDescription: product.productDescription,
      KProdcutLocation: product.productLocation,
      KProdcutPrice: product.productPrice,
    }).then((value) {
      print(value);
    });
  }
}
