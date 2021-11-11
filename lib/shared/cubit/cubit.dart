import 'package:bloc/bloc.dart';
import 'package:buy_it/models/product_model.dart';
import 'package:buy_it/services/store.dart';
import 'package:buy_it/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyItCubit extends Cubit<BuyItStates> {
  BuyItCubit() : super(BuyItInitState());
  static BuyItCubit object(context) => BlocProvider.of(context);

  bool isVisible = true;
  void changeIconVisibility() {
    isVisible = !isVisible;
    emit(ChangeSuffixIconState());
  }

  bool isLoading = false;
  void changeIsLoading() {
    emit(ChangeIsLoadingLoadingState());
    isLoading = !isLoading;
    emit(ChangeIsLoadingSuccessState());
  }

  bool isAdmin = false;
  var selectedVal = AdminOrUser.USER;
  void changeAdminOrUser(AdminOrUser value) {
    selectedVal = value;
    if (value == AdminOrUser.ADMIN) {
      isAdmin = true;
    } else {
      isAdmin = false;
    }
    print('Is Admin = $isAdmin');
    emit(ChangeBetweenAdminOrUserState());
  }

  final Store store = Store();
  List<Product> allProducts = [];

  void getAllProducts() async {
    allProducts = await store.getAllProducts();
  }

  bool isAddingProduct = false;

  int tabBarIndex = 0;
  void changeTabBarIndex(int index) {
    tabBarIndex = index;
    emit(ChangeTabBarIndexState());
  }

  int bottomNavigationBarIndex = 0;
  void changeBottomNavigationBarIndex(int index) {
    bottomNavigationBarIndex = index;
    emit(ChangeBottomNavigationBarIndexState());
  }
}

enum AdminOrUser {
  ADMIN,
  USER,
}
