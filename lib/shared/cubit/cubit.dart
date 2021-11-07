import 'package:bloc/bloc.dart';
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
}
