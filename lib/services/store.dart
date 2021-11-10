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
      KProdcutImage: product.productImage,
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

  Future deleteProduct({productId}) async {
    return await firebaseFirestore
        .collection(KProdcutCollection)
        .doc(productId)
        .delete();
  }

  Future editProduct({
    required Product product,
    productId,
  }) async {
    await firebaseFirestore
        .collection(KProdcutCollection)
        .doc(productId)
        .update({
      KProdcutName: product.productName,
      KProdcutCategory: product.productCategory,
      KProdcutDescription: product.productDescription,
      KProdcutPrice: product.productPrice,
      KProdcutImage: product.productImage,
    });
  }

  Future getProductData({id}) async {
    return await firebaseFirestore.collection(KProdcutCollection).doc(id).get();
  }
}
