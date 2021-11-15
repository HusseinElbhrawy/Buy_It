import 'package:buy_it/models/product_model.dart';
import 'package:buy_it/screens/user/product_info.dart';
import 'package:buy_it/services/store.dart';
import 'package:buy_it/shared/components/components.dart';
import 'package:buy_it/shared/components/const.dart';
import 'package:buy_it/shared/components/custom_pop_up_menu.dart';
import 'package:buy_it/shared/cubit/cubit.dart';
import 'package:buy_it/shared/cubit/states.dart';
import 'package:buy_it/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const String id = 'CartScreen';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BuyItCubit, BuyItStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = BuyItCubit.object(context);
        List<Product> products = cubit.allProducts;
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              titleSpacing: 0,
              title: const Text(
                'My Cart',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: ConditionalBuilder(
              condition: products.isEmpty,
              builder: (BuildContext context) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/shopping.png'),
                  const Text(
                    'Cart Is Empty , please fill it ',
                    style: TextStyle(fontSize: 25.0, fontFamily: 'Pacifico'),
                  )
                ],
              ),
              fallback: (BuildContext context) => Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => GestureDetector(
                              onTapUp: (details) {
                                double dx = details.globalPosition.dx;
                                double dy = details.globalPosition.dy;
                                double dx2 =
                                    MediaQuery.of(context).size.width - dx;
                                double dy2 =
                                    MediaQuery.of(context).size.height - dy;

                                showMenu(
                                  context: context,
                                  position:
                                      RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                                  items: [
                                    MyPopUpMenuItem(
                                      childWidget: const Text('Edit'),
                                      onClick: () {
                                        Navigator.pop(context);
                                        Navigator.pushNamed(
                                          context,
                                          ProductInfo.id,
                                          arguments: products[index],
                                        ).then((value) {
                                          cubit.editProductInCart = true;
                                        });
                                      },
                                    ),
                                    MyPopUpMenuItem(
                                      childWidget: const Text('Delete'),
                                      onClick: () {
                                        Navigator.pop(context);
                                        cubit.deleteProduct(products[index]);
                                      },
                                    ),
                                  ],
                                );
                              },
                              child: CartItemWidget(
                                height: height,
                                width: width,
                                product: products,
                                index: index,
                              ),
                            ),
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: products.length),
                  ),
                  Builder(builder: (context) {
                    return ElevatedButton(
                      style: buildElevatedButtonStyle(context),
                      onPressed: () {
                        showCustomDialog(products, context);
                      },
                      child: Text(
                        'order'.toUpperCase(),
                        style: TextStyle(
                          letterSpacing: 2.5,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.040,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showCustomDialog(List<Product> product, context) {
    var price = getTotalPrice(product);
    var address = TextEditingController();
    AlertDialog alertDialog = AlertDialog(
      title: Text('Total Price = $price  \$'),
      content: LoginTextFormFiledWidget(
        controller: address,
        prefixIcon: Icons.home,
        hint: 'Address',
        errorMessage: 'Error',
        keyboardType: TextInputType.text,
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // try {
            Store store = Store();
            store.storeOrders(
              {
                kTotalPrice: price,
                kAddress: address.text,
              }.values,
              product,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Ordered Successfully'),
              ),
            );
            /* } catch (e) {
              // print(e);
            }*/
          },
          child: const Text('Confirm'),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.all(
              Radius.circular(MediaQuery.of(context).size.width * 0.055),
            ))),
            backgroundColor: MaterialStateProperty.all(
              KMainColor,
            ),
          ),
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  double getTotalPrice(List<Product> products) {
    var price = 0;
    for (var pro in products) {
      price += (int.parse(pro.productPrice.toString()) *
          pro.productQuantity!.toInt());
    }
    return price.toDouble();
  }
}

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.product,
    required this.index,
  }) : super(key: key);

  final List<Product> product;
  final double height;
  final double width;
  final int index;

  @override
  Widget build(BuildContext context) {
    double totalPrice = product[index].productQuantity! *
        double.parse(product[index].productPrice.toString());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
            color: KSeconderyColor,
            borderRadius: BorderRadiusDirectional.all(Radius.circular(15))),
        height: height * 0.20,
        child: Row(
          children: [
            CircleAvatar(
              radius: height * 0.20 / 2,
              backgroundImage: NetworkImage(
                product[index].productImage.toString(),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  product[index].productName.toString(),
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  totalPrice.toString(),
                  style: const TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsetsDirectional.only(
                end: width * 0.050,
              ),
              child: Text(product[index].productQuantity.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
