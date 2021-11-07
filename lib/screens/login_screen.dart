import 'package:buy_it/screens/admin_screen.dart';
import 'package:buy_it/screens/sign_up_screen.dart';
import 'package:buy_it/screens/user_screen.dart';
import 'package:buy_it/services/auth.dart';
import 'package:buy_it/shared/components/components.dart';
import 'package:buy_it/shared/components/const.dart';
import 'package:buy_it/shared/cubit/cubit.dart';
import 'package:buy_it/shared/cubit/states.dart';
import 'package:buy_it/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  suffixIcon: suffixIconOnOff(cubit),
                  suffixIconOnPressed: () {
                    cubit.changeIconVisibility();
                  },
                ),
                ConditionalBuilder(
                  condition: cubit.isLoading,
                  fallback: (BuildContext context) {
                    return Padding(
                      padding: signupAndSignInTextButtonPadding(context),
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
                            formKey.currentState!.save();
                            cubit.changeIsLoading();
                            if (cubit.isAdmin) {
                              if (passwordController.text == KAdminPassword) {
                                await ifIsUserOrAdminTrue(
                                  cubit: cubit,
                                  context: context,
                                  auth: auth,
                                  emailController: emailController,
                                  passwordController: passwordController,
                                  screen: AdminScreen.id,
                                );
                              } else {
                                adminErrorMotionToast(context);
                                cubit.changeIsLoading();
                              }
                            } else {
                              if (passwordController.text != KAdminPassword) {
                                await ifIsUserOrAdminTrue(
                                  cubit: cubit,
                                  context: context,
                                  emailController: emailController,
                                  passwordController: passwordController,
                                  auth: auth,
                                  screen: UserScreen.id,
                                );
                              } else {
                                adminErrorMotionToast(context);
                                cubit.changeIsLoading();
                              }
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
                    );
                  },
                  builder: (BuildContext context) => const Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: AdminOrUser.ADMIN,
                      groupValue: cubit.selectedVal,
                      onChanged: (AdminOrUser? value) {
                        cubit.changeAdminOrUser(value!);
                      },
                      fillColor: MaterialStateProperty.all(Colors.deepOrange),
                    ),
                    const Text(
                      'Admin',
                      style: TextStyle(fontFamily: 'Jannah'),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.070,
                    ),
                    Radio(
                      value: AdminOrUser.USER,
                      groupValue: cubit.selectedVal,
                      onChanged: (AdminOrUser? value) {
                        cubit.changeAdminOrUser(value!);
                      },
                    ),
                    const Text(
                      'User',
                      style: TextStyle(fontFamily: 'Jannah'),
                    ),
                  ],
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
