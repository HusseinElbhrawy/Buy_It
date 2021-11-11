import 'package:buy_it/shared/cubit/cubit.dart';
import 'package:buy_it/shared/cubit/states.dart';
import 'package:buy_it/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);
  static const String id = 'HomeScreen';
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 4,
          child: BlocConsumer<BuyItCubit, BuyItStates>(
            listener: (BuildContext context, state) {},
            builder: (BuildContext context, Object? state) {
              var cubit = BuyItCubit.object(context);
              return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  bottom: TabBar(
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    physics: const ScrollPhysics(),
                    indicatorColor: KSeconderyColor,
                    onTap: (value) {
                      cubit.changeTabBarIndex(value);
                    },
                    tabs: const [
                      Text(
                        'Tab 1',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Tab 2',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Tab 3',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Tab 4',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                body: const TabBarView(
                  children: [
                    Center(
                      child: Text('Testing 1'),
                    ),
                    Center(
                      child: Text('Testing 2'),
                    ),
                    Center(
                      child: Text('Testing 3'),
                    ),
                    Center(
                      child: Text('Testing 4'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(
            top: MediaQuery.of(context).size.width * 0.036,
            start: MediaQuery.of(context).size.width * 0.036,
            end: MediaQuery.of(context).size.width * 0.036,
          ),
          child: SafeArea(
            child: Material(
              child: Container(
                color: KMainColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'discovered'.toUpperCase(),
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.050,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(Icons.shopping_cart),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
