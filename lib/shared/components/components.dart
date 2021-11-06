import 'package:buy_it/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class LoginTextFormFiledWidget extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextInputType keyboardType;
  final String errorMessage;

  const LoginTextFormFiledWidget(
      {Key? key,
      required this.errorMessage,
      required this.hint,
      required this.icon,
      required this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: MediaQuery.of(context).size.width * 0.036,
        end: MediaQuery.of(context).size.width * 0.036,
        bottom: MediaQuery.of(context).size.width * 0.050,
      ),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return errorMessage;
          }
          return null;
        },
        keyboardType: keyboardType,
        cursorColor: KMainColor,
        decoration: textFormFieldDecoration(icon: icon, hint: hint),
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
