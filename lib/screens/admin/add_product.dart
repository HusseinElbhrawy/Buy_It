import 'package:buy_it/models/product_model.dart';
import 'package:buy_it/services/store.dart';
import 'package:buy_it/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({Key? key}) : super(key: key);
  static const id = 'AppProduct';
  static var productName = TextEditingController();
  static var productPrice = TextEditingController();
  static var productDescription = TextEditingController();
  static var productCategory = TextEditingController();
  static var productLocation = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final Store firebaseStore = Store();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Product '),
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(start: width * 0.045),
                child: Text(
                  'Products Details',
                  style: TextStyle(
                    fontSize: width * 0.070,
                    fontFamily: 'Pacifico',
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.050,
              ),
              LoginTextFormFiledWidget(
                controller: productName,
                prefixIcon: Icons.info,
                hint: 'Product Name',
                errorMessage: 'Product Name Must Not Be Empty',
                keyboardType: TextInputType.text,
              ),
              LoginTextFormFiledWidget(
                controller: productPrice,
                prefixIcon: Icons.info,
                hint: 'Product Price',
                errorMessage: 'Product Price Must Not Be Empty',
                keyboardType: TextInputType.text,
              ),
              LoginTextFormFiledWidget(
                controller: productDescription,
                prefixIcon: Icons.info,
                hint: 'Product Description',
                errorMessage: 'Product Description Must Not Be Empty',
                keyboardType: TextInputType.text,
              ),
              LoginTextFormFiledWidget(
                controller: productCategory,
                prefixIcon: Icons.info,
                hint: 'Product Category',
                errorMessage: 'Product Category Must Not Be Empty',
                keyboardType: TextInputType.text,
              ),
              LoginTextFormFiledWidget(
                controller: productLocation,
                prefixIcon: Icons.info,
                hint: 'Product Location',
                errorMessage: 'Product Location Must Not Be Empty',
                keyboardType: TextInputType.text,
              ),
              Center(
                child: Container(
                  padding: EdgeInsetsDirectional.only(
                    start: width * 0.045,
                    end: width * 0.045,
                  ),
                  width: double.infinity,
                  child: Builder(builder: (context) {
                    return TextButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          try {
                            await firebaseStore.addProduct(
                              Product(
                                productName: productName.text,
                                productPrice: productPrice.text,
                                productDescription: productDescription.text,
                                productCategory: productCategory.text,
                                productLocation: productLocation.text,
                              ),
                            );
                            MotionToast.success(
                              title: "Success",
                              titleStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              description: 'Added Product Successfully ',
                            ).show(context);
                            clearAllControllerData();
                          } catch (e) {
                            MotionToast.error(
                              title: "Error",
                              titleStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              description: 'SomeThing Error ',
                            ).show(context);
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.black,
                        ),
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Add Product',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void clearAllControllerData() {
    productName.clear();
    productPrice.clear();
    productDescription.clear();
    productCategory.clear();
    productLocation.clear();
  }
}
