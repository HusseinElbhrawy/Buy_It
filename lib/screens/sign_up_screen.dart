import 'package:buy_it/screens/login_screen.dart';
import 'package:buy_it/services/auth.dart';
import 'package:buy_it/shared/components/components.dart';
import 'package:buy_it/shared/cubit/cubit.dart';
import 'package:buy_it/shared/cubit/states.dart';
import 'package:buy_it/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user/user_screen.dart';

class SignUpScreen extends StatelessWidget {
  static String id = 'SignUpScreen';
  SignUpScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
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
                  suffixIcon: suffixIconOnOff(cubit),
                  suffixIconOnPressed: () {
                    cubit.changeIconVisibility();
                  },
                  controller: passwordController,
                ),
                ConditionalBuilder(
                  condition: cubit.isLoading,
                  fallback: (BuildContext context) {
                    return Padding(
                      padding: signupAndSignInTextButtonPadding(context),
                      child: TextButton(
                        style: signUpAndSignInTextButtonStyle(),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            cubit.changeIsLoading();
                            try {
                              await auth
                                  .signUp(
                                email: emailController.text,
                                password: passwordController.text,
                              )
                                  .then((value) {
                                cubit.changeIsLoading();
                                Navigator.pushNamed(context, UserScreen.id);
                              });
                            } on FirebaseAuthException catch (e) {
                              errorMotionToast(e, context);
                              cubit.changeIsLoading();
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
                    );
                  },
                  builder: (BuildContext context) => const Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
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
