import 'package:buy_it/models/product_model.dart';
import 'package:buy_it/screens/admin/managed_product.dart';
import 'package:buy_it/services/store.dart';
import 'package:buy_it/shared/components/components.dart';
import 'package:buy_it/shared/cubit/cubit.dart';
import 'package:buy_it/shared/cubit/states.dart';
import 'package:buy_it/shared/styles/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatelessWidget {
  UserScreen({Key? key}) : super(key: key);
  static const String id = 'HomeScreen';
  final store = Store();
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
                body: TabBarView(
                  children: [
                    jacketWidget(),
                    const Center(
                      child: Text('Testing 2'),
                    ),
                    const Center(
                      child: Text('Testing 3'),
                    ),
                    const Center(
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

  Widget jacketWidget() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: store.getAllProducts(),
      builder: (BuildContext context, snapshot) {
        return ConditionalBuilder(
          condition: snapshot.hasData,
          builder: (BuildContext context) {
            List<Product> products = [];
            addNewProductWithSnapshot(snapshot, products);
            return GridView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: BuyItItemWidget(
                  index: index,
                  products: products,
                ),
              ),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.5,
              ),
            );
          },
          fallback: (BuildContext context) => const Center(
            child: CircularProgressIndicator(
              color: Colors.deepOrange,
            ),
          ),
        );
      },
    );
  }
}
