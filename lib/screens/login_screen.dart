import 'package:buy_it/shared/components/components.dart';
import 'package:buy_it/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: KMainColor,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Padding(
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
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadiusDirectional.all(Radius.circular(12.5)),
                  ))),
              onPressed: () {},
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
                  onPressed: () {},
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
  }
}
