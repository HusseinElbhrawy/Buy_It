import 'package:bloc/bloc.dart';
import 'package:buy_it/screens/login_screen.dart';
import 'package:buy_it/screens/sign_up_screen.dart';
import 'package:buy_it/shared/cubit/bloc_observer.dart';
import 'package:buy_it/shared/cubit/cubit.dart';
import 'package:buy_it/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BuyItCubit>(
      create: (BuildContext context) => BuyItCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => const LoginScreen(),
          SignUpScreen.id: (context) => const SignUpScreen(),
        },
        theme: lightTheme,
        themeMode: ThemeMode.light,
      ),
    );
  }
}
