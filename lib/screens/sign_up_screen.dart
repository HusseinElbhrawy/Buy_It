import 'package:buy_it/screens/login_screen.dart';
import 'package:buy_it/services/auth.dart';
import 'package:buy_it/shared/components/components.dart';
import 'package:buy_it/shared/cubit/cubit.dart';
import 'package:buy_it/shared/cubit/states.dart';
import 'package:buy_it/shared/styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';

class SignUpScreen extends StatelessWidget {
  static String id = 'SignUpScreen';
  const SignUpScreen({Key? key}) : super(key: key);
  static final fromKey = GlobalKey<FormState>();
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
            key: fromKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                const LoginAndSignUpLogoAndTextWidget(),
                const LoginTextFormFiledWidget(
                  hint: 'Enter Your Name',
                  prefixIcon: Icons.perm_identity,
                  keyboardType: TextInputType.name,
                  errorMessage: 'Name Must Not Be Empty',
                ),
                LoginTextFormFiledWidget(
                  hint: 'Enter Your Email',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  errorMessage: 'Email Must Not Be Empty',
                  controller: emailController,
                ),
                LoginTextFormFiledWidget(
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
                  controller: passwordController,
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
                      if (fromKey.currentState!.validate()) {
                        fromKey.currentState!.save();
                        try {
                          await auth.signUp(
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
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.025),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Do have an account ?",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Jannah',
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        child: Text(
                          "Login",
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
