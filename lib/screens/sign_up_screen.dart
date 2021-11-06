import 'package:buy_it/screens/login_screen.dart';
import 'package:buy_it/shared/components/components.dart';
import 'package:buy_it/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  static String id = 'SignUpScreen';
  const SignUpScreen({Key? key}) : super(key: key);
  static final fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: KMainColor,
      body: Form(
        key: fromKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            const LoginAndSignUpLogoAndTextWidget(),
            const LoginTextFormFiledWidget(
              hint: 'Enter Your Name',
              icon: Icons.perm_identity,
              keyboardType: TextInputType.name,
            ),
            const LoginTextFormFiledWidget(
              hint: 'Enter Your Email',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const LoginTextFormFiledWidget(
              hint: 'Enter Your Password',
              icon: Icons.lock,
              keyboardType: TextInputType.visiblePassword,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.28,
                vertical: MediaQuery.of(context).size.height * 0.028,
              ),
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape:
                        MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadiusDirectional.all(Radius.circular(12.5)),
                    ))),
                onPressed: () {
                  if (fromKey.currentState!.validate()) {}
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
                  vertical: MediaQuery.of(context).size.height * 0.030),
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
      ),
    );
  }
}
