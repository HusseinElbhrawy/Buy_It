import 'package:buy_it/services/store.dart';
import 'package:buy_it/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class EditProductScreen extends StatelessWidget {
  static const String id = 'EditProductScreen';
  static final productName = TextEditingController();
  static final productPrice = TextEditingController();
  static final productDescription = TextEditingController();
  static final productCategory = TextEditingController();
  static final productLocation = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final firebaseStore = Store();

  EditProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit  Product '),
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
                controller: EditProductScreen.productName,
                prefixIcon: Icons.info,
                hint: 'Product Name',
                errorMessage: 'Product Name Must Not Be Empty',
                keyboardType: TextInputType.text,
              ),
              LoginTextFormFiledWidget(
                controller: EditProductScreen.productPrice,
                prefixIcon: Icons.info,
                hint: 'Product Price',
                errorMessage: 'Product Price Must Not Be Empty',
                keyboardType: TextInputType.text,
              ),
              LoginTextFormFiledWidget(
                controller: EditProductScreen.productDescription,
                prefixIcon: Icons.info,
                hint: 'Product Description',
                errorMessage: 'Product Description Must Not Be Empty',
                keyboardType: TextInputType.text,
              ),
              LoginTextFormFiledWidget(
                controller: EditProductScreen.productCategory,
                prefixIcon: Icons.info,
                hint: 'Product Category',
                errorMessage: 'Product Category Must Not Be Empty',
                keyboardType: TextInputType.text,
              ),
              LoginTextFormFiledWidget(
                controller: EditProductScreen.productLocation,
                prefixIcon: Icons.info,
                hint: 'Product Image',
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
                            //TODO: Logic of Editing  here
                            /*firebaseStore
                                .editProduct(
                              product: Product(
                                productName: EditProductScreen.productName.text,
                                productPrice:
                                    EditProductScreen.productPrice.text,
                                productDescription:
                                    EditProductScreen.productDescription.text,
                                productCategory:
                                    EditProductScreen.productCategory.text,
                                productImage:
                                    EditProductScreen.productLocation.text,
                              ),
                              productId: product.productId,
                            )
                                .then((value) {
                              print({'$value Edit Successfully'});
                            });*/
                            MotionToast.success(
                              title: "Success",
                              titleStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              description: 'Edit Product Successfully ',
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
                        'Edit  Product',
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
    EditProductScreen.productName.clear();
    EditProductScreen.productPrice.clear();
    EditProductScreen.productDescription.clear();
    EditProductScreen.productCategory.clear();
    EditProductScreen.productLocation.clear();
  }
}
