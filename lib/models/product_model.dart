class Product {
  late String productName;
  late String? productPrice;
  late String? productDescription;
  late String? productCategory;
  late String? productImage;
  late String? productId;

  Product({
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.productCategory,
    required this.productImage,
    this.productId,
  });
}
