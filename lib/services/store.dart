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

/*
  Future<List<Product>> getAllProducts() async {
    var snapshot = await firebaseFirestore.collection(KProdcutCollection).get();
    List<Product> products = [];
    for (var doc in snapshot.docs) {
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
    return products;
  }
*/

  getAllProducts() {
    return firebaseFirestore.collection(KProdcutCollection).snapshots();
  }
}
