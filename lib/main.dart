import 'package:bloc/bloc.dart';
import 'package:buy_it/screens/admin/add_product.dart';
import 'package:buy_it/screens/admin/admin_screen.dart';
import 'package:buy_it/screens/admin/edit_product_screen.dart';
import 'package:buy_it/screens/admin/managed_product.dart';
import 'package:buy_it/screens/login_screen.dart';
import 'package:buy_it/screens/sign_up_screen.dart';
import 'package:buy_it/screens/user/product_info.dart';
import 'package:buy_it/screens/user/user_screen.dart';
import 'package:buy_it/shared/cubit/bloc_observer.dart';
import 'package:buy_it/shared/cubit/cubit.dart';
import 'package:buy_it/shared/styles/styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
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
          LoginScreen.id: (context) => LoginScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          UserScreen.id: (context) => UserScreen(),
          AdminScreen.id: (context) => const AdminScreen(),
          AddProductScreen.id: (context) => AddProductScreen(),
          ManagedProductScreen.id: (context) => ManagedProductScreen(),
          EditProductScreen.id: (context) => EditProductScreen(),
          ProductInfo.id: (context) => const ProductInfo(),
        },
        theme: lightTheme,
        themeMode: ThemeMode.light,
      ),
    );
  }
}
