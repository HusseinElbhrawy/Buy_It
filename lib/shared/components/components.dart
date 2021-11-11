import 'package:buy_it/models/product_model.dart';
import 'package:buy_it/screens/user/product_info.dart';
import 'package:buy_it/services/auth.dart';
import 'package:buy_it/services/store.dart';
import 'package:buy_it/shared/cubit/cubit.dart';
import 'package:buy_it/shared/styles/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

import '../functions.dart';

class LoginTextFormFiledWidget extends StatelessWidget {
  final String hint;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final TextInputType keyboardType;
  final String errorMessage;
  final bool secure;
  final Function? suffixIconOnPressed;
  final Function? onFieldSubmitted;
  final TextEditingController? controller;
  const LoginTextFormFiledWidget({
    Key? key,
    this.secure = false,
    required this.errorMessage,
    required this.hint,
    required this.prefixIcon,
    required this.keyboardType,
    this.suffixIcon,
    this.suffixIconOnPressed,
    this.controller,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: MediaQuery.of(context).size.width * 0.036,
        end: MediaQuery.of(context).size.width * 0.036,
        bottom: MediaQuery.of(context).size.width * 0.050,
      ),
      child: TextFormField(
        onFieldSubmitted: (value) => onFieldSubmitted!(value),
        controller: controller,
        obscureText: secure,
        validator: (value) {
          if (value!.isEmpty) {
            return errorMessage;
          }
          return null;
        },
        keyboardType: keyboardType,
        cursorColor: KMainColor,
        decoration: textFormFieldDecoration(
          icon: prefixIcon,
          hint: hint,
        ),
      ),
    );
  }

  InputDecoration textFormFieldDecoration(
      {required String hint, required IconData icon}) {
    return InputDecoration(
      filled: true,
      fillColor: KSeconderyColor,
      enabledBorder: textFormFieldBorderDecoration(),
      focusedBorder: textFormFieldBorderDecoration(),
      border: textFormFieldBorderDecoration(),
      hintText: hint,
      prefixIcon: Icon(
        icon,
        color: KMainColor,
      ),
      suffixIcon: GestureDetector(
        onTap: () => suffixIconOnPressed!(),
        child: Icon(
          suffixIcon,
          color: KMainColor,
        ),
      ),
    );
  }

  OutlineInputBorder textFormFieldBorderDecoration() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(15.0),
      ),
      borderSide: BorderSide(
        color: Colors.white,
      ),
    );
  }
}

class LoginAndSignUpLogoAndTextWidget extends StatelessWidget {
  const LoginAndSignUpLogoAndTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.095),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            backgroundColor: KMainColor,
            radius: 50.0,
            child: Image.asset(
              'assets/images/icons/buy.png',
              fit: BoxFit.cover,
            ),
          ),
          Text(
            'Buy it',
            style: TextStyle(
              fontFamily: 'Pacifico',
              fontSize: MediaQuery.of(context).size.height * 0.037,
            ),
          ),
        ],
      ),
    );
  }
}

IconData suffixIconOnOff(BuyItCubit cubit) {
  return cubit.isVisible ? Icons.visibility_outlined : Icons.visibility_off;
}

ButtonStyle signUpAndSignInTextButtonStyle() {
  return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.black),
      shape: MaterialStateProperty.all(const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.all(Radius.circular(12.5)),
      )));
}

void errorMotionToast(FirebaseAuthException e, BuildContext context) {
  MotionToast.error(
    title: "Error",
    titleStyle: const TextStyle(fontWeight: FontWeight.bold),
    description: e.message.toString(),
  ).show(context);
}

EdgeInsets signupAndSignInTextButtonPadding(BuildContext context) {
  return EdgeInsets.symmetric(
    horizontal: MediaQuery.of(context).size.width * 0.28,
    vertical: MediaQuery.of(context).size.height * 0.028,
  );
}

Future<void> ifIsUserOrAdminTrue({
  required BuyItCubit cubit,
  required BuildContext context,
  required Auth auth,
  required TextEditingController emailController,
  required TextEditingController passwordController,
  required String screen,
}) async {
  try {
    await auth
        .signIn(
      email: emailController.text,
      password: passwordController.text,
    )
        .then((value) {
      cubit.changeIsLoading();
      Navigator.pushNamed(context, screen);
    });
  } on FirebaseAuthException catch (e) {
    errorMotionToast(e, context);
    cubit.changeIsLoading();
  }
}

void adminErrorMotionToast(BuildContext context) {
  MotionToast.error(
    title: "Error",
    titleStyle: const TextStyle(fontWeight: FontWeight.bold),
    description: 'Something Error !',
  ).show(context);
}

class BuyItItemWidget extends StatelessWidget {
  const BuyItItemWidget({Key? key, required this.index, required this.products})
      : super(key: key);
  final List<Product> products;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(15),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              products[index].productImage.toString(),
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Opacity(
              opacity: .5,
              child: Container(
                color: Colors.white,
                height: 60.0,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        products[index].productName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Jannah',
                        ),
                      ),
                      Text(
                        "\$ ${products[index].productPrice}",
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget tabBarItemViewWidget({
  required List<Product> categoryProduct,
  required String category,
  required Store store,
}) {
  return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
    stream: store.getAllProducts(),
    builder: (BuildContext context, snapshot) {
      return ConditionalBuilder(
        condition: snapshot.hasData,
        builder: (BuildContext context) {
          List<Product> products = [];
          categoryProduct = [];
          addNewProductWithSnapshot(snapshot, products);
          for (var pro in products) {
            if (pro.productCategory == category) {
              categoryProduct.add(pro);
            }
          }
          return GridView.builder(
            itemBuilder: (context, index) => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ProductInfo.id,
                    arguments: categoryProduct[index],
                  );
                },
                child: BuyItItemWidget(
                  index: index,
                  products: categoryProduct,
                ),
              ),
            ),
            itemCount: categoryProduct.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.5,
            ),
          );
        },
        fallback: (BuildContext context) => const Center(
          child: CircularProgressIndicator(
            color: Colors.deepOrange,
          ),
        ),
      );
    },
  );
}
