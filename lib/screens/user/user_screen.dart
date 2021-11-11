import 'package:buy_it/models/product_model.dart';
import 'package:buy_it/services/store.dart';
import 'package:buy_it/shared/components/components.dart';
import 'package:buy_it/shared/components/const.dart';
import 'package:buy_it/shared/cubit/cubit.dart';
import 'package:buy_it/shared/cubit/states.dart';
import 'package:buy_it/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatelessWidget {
  UserScreen({Key? key}) : super(key: key);
  static const String id = 'HomeScreen';
  final store = Store();
  final List<Product> jacketProducts = [];
  final List<Product> trouserProducts = [];
  final List<Product> shoesProducts = [];
  final List<Product> tShirtProducts = [];

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
                backgroundColor: Colors.white,
                bottomNavigationBar: BottomNavigationBar(
                  elevation: 0.0,
                  backgroundColor: Colors.white,
                  selectedItemColor: KMainColor,
                  currentIndex: cubit.bottomNavigationBarIndex,
                  onTap: (value) {
                    cubit.changeBottomNavigationBarIndex(value);
                    print(tShirtProducts.length);
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Testing',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.add),
                      label: 'Testing',
                    ),
                  ],
                ),
                appBar: AppBar(
                  elevation: 0.0,
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  bottom: TabBar(
                    physics: const ScrollPhysics(),
                    indicatorColor: KMainColor,
                    onTap: (value) {
                      cubit.changeTabBarIndex(value);
                    },
                    tabs: const [
                      Text(
                        'Jackets',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Trousers',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'shoes',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'T-Shirt',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    tabBarItemViewWidget(
                        categoryProduct: jacketProducts,
                        category: KJacket,
                        store: store),
                    tabBarItemViewWidget(
                        categoryProduct: trouserProducts,
                        category: KTrouser,
                        store: store),
                    tabBarItemViewWidget(
                        categoryProduct: shoesProducts,
                        category: KShose,
                        store: store),
                    tabBarItemViewWidget(
                        categoryProduct: tShirtProducts,
                        category: KTShirt,
                        store: store),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(
            top: MediaQuery.of(context).size.width * 0.060,
            start: MediaQuery.of(context).size.width * 0.036,
            end: MediaQuery.of(context).size.width * 0.036,
          ),
          child: SafeArea(
            child: Material(
              child: Container(
                color: Colors.white,
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
