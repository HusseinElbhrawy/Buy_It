import 'package:buy_it/services/auth.dart';
import 'package:buy_it/shared/cubit/cubit.dart';
import 'package:buy_it/shared/styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

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
