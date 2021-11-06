import 'package:buy_it/screens/login_screen.dart';
import 'package:buy_it/screens/sign_up_screen.dart';
import 'package:buy_it/shared/styles/styles.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => const LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
      },
      theme: lightTheme,
      themeMode: ThemeMode.light,
    );
  }
}
