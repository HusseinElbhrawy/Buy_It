import 'package:buy_it/screens/sign_up_screen.dart';
import 'package:buy_it/services/auth.dart';
import 'package:buy_it/shared/components/components.dart';
import 'package:buy_it/shared/cubit/cubit.dart';
import 'package:buy_it/shared/cubit/states.dart';
import 'package:buy_it/shared/styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';
  const LoginScreen({Key? key}) : super(key: key);
  static final formKey = GlobalKey<FormState>();
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController =
      TextEditingController();
  static final auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KMainColor,
      body: BlocConsumer<BuyItCubit, BuyItStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          BuyItCubit cubit = BuyItCubit.object(context);
          return Form(
            key: formKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.095),
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
                ),
                LoginTextFormFiledWidget(
                  controller: emailController,
                  hint: 'Enter Your Email',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  errorMessage: 'Email Must Not Be Empty',
                ),
                LoginTextFormFiledWidget(
                  controller: passwordController,
                  hint: 'Enter Your Password',
                  prefixIcon: Icons.lock,
                  keyboardType: TextInputType.visiblePassword,
                  errorMessage: 'Password Must Not Be Empty',
                  secure: cubit.isVisible,
                  suffixIcon: cubit.isVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off,
                  suffixIconOnPressed: () {
                    cubit.changeIconVisibility();
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.28,
                    vertical: MediaQuery.of(context).size.height * 0.028,
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.all(
                              Radius.circular(12.5)),
                        ))),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          await auth.signIn(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        } on FirebaseAuthException catch (e) {
                          MotionToast.error(
                                  title: "Error",
                                  titleStyle: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  description: e.message.toString())
                              .show(context);
                        }
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.030),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ?",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Jannah',
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SignUpScreen.id);
                        },
                        child: Text(
                          "Register here",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.045,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
