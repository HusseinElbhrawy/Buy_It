import 'package:buy_it/models/product_model.dart';
import 'package:buy_it/screens/user/cart_screen.dart';
import 'package:buy_it/shared/components/components.dart';
import 'package:buy_it/shared/cubit/cubit.dart';
import 'package:buy_it/shared/cubit/states.dart';
import 'package:buy_it/shared/functions.dart';
import 'package:buy_it/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({Key? key}) : super(key: key);
  static const String id = 'ProductInfo';
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)!.settings.arguments as Product;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.09,
              ),
              child: Image.network(
                product.productImage.toString(),
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                top: MediaQuery.of(context).size.width * 0.070,
                start: MediaQuery.of(context).size.width * 0.036,
                end: MediaQuery.of(context).size.width * 0.036,
              ),
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                    InkWell(
                      child: const Icon(Icons.shopping_cart),
                      onTap: () {
                        Navigator.pushNamed(context, CartScreen.id);
                      },
                    ),
                  ],
                ),
              ),
            ),
            BlocConsumer<BuyItCubit, BuyItStates>(
              listener: (BuildContext context, state) {},
              builder: (BuildContext context, Object? state) {
                var cubit = BuyItCubit.object(context);
                return Positioned(
                  bottom: 0.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Opacity(
                        opacity: .8,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(start: 15.0),
                              child: Text(
                                'Name: ${product.productName}',
                                style: const TextStyle(
                                  fontSize: 20.5,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Jannah',
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.010,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(start: 15.0),
                              child: Text(
                                'Description: ${product.productDescription.toString()}',
                                style: const TextStyle(
                                  fontSize: 15.5,
                                  fontFamily: 'Jannah',
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.010,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(start: 15.0),
                              child: Text(
                                'Price:  ${product.productPrice} \$ ',
                                style: const TextStyle(
                                  fontSize: 20.5,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Jannah',
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.005,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                start: width * 0.050,
                              ),
                              child: CircleAvatar(
                                backgroundColor: KSeconderyColor,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.remove,
                                  ),
                                  onPressed: () {
                                    cubit.decrementNumberOfProductItems();
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.040,
                            ),
                            Text(
                              cubit.numberOfProductItems.toString(),
                              style: const TextStyle(fontSize: 25.0),
                            ),
                            SizedBox(
                              width: width * 0.040,
                            ),
                            CircleAvatar(
                              backgroundColor: KSeconderyColor,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.add,
                                ),
                                onPressed: () {
                                  cubit.incrementNumberOfProductItems();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.055,
                      ),
                      ElevatedButton(
                        style: buildElevatedButtonStyle(context),
                        onPressed: () {
                          addToCardFunction(product, cubit, context);
                        },
                        child: Text(
                          'Add to Cart'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.040,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
