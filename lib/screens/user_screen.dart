import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);
  static const String id = 'HomeScreen';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('User Screen'),
      ),
    );
  }
}
