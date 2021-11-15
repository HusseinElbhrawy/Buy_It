import 'package:buy_it/models/product_model.dart';
import 'package:buy_it/shared/components/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  addProduct(Product product) async {
    return firebaseFirestore.collection(kProductCollection).add({
      kProductName: product.productName,
      kProductCategory: product.productCategory,
      kProductDescription: product.productDescription,
      kProductImage: product.productImage,
      kProductPrice: product.productPrice,
    }).then((value) {
      print(value);
    });
  }

/*
  Future<List<Product>> getAllProducts() async {
    var snapshot = await firebaseFirestore.collection(KProductCollection).get();
    List<Product> products = [];
    for (var doc in snapshot.docs) {
      var data = doc.data();
      products.add(
        Product(
          productName: data[KProductName],
          productPrice: data[KProductPrice],
          productDescription: data[KProductsDescription],
          productCategory: data[KProductCategory],
          productLocation: data[KProductLocation],
        ),
      );
    }
    return products;
  }
*/

  getAllProducts() {
    return firebaseFirestore.collection(kProductCollection).snapshots();
  }

  Future deleteProduct({productId}) async {
    return await firebaseFirestore
        .collection(kProductCollection)
        .doc(productId)
        .delete();
  }

  Future editProduct({
    required Product product,
    productId,
  }) async {
    await firebaseFirestore
        .collection(kProductCollection)
        .doc(productId)
        .update({
      kProductName: product.productName,
      kProductCategory: product.productCategory,
      kProductDescription: product.productDescription,
      kProductPrice: product.productPrice,
      kProductImage: product.productImage,
    });
  }

  Future getProductData({id}) async {
    return await firebaseFirestore.collection(kProductCollection).doc(id).get();
  }

  storeOrders(data, List<Product> products) {
    var docRef = firebaseFirestore.collection(kOrders).doc();
    docRef.get(data);
    for (var product in products) {
      docRef.collection(kOrdersDetails).doc().set({
        kProductName: product.productName,
        kProductPrice: product.productPrice,
        kProductQuantity: product.productQuantity,
        kProductImage: product.productImage,
      });
    }
  }
}
