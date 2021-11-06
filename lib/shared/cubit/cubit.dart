import 'package:bloc/bloc.dart';
import 'package:buy_it/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyItCubit extends Cubit<BuyItStates> {
  BuyItCubit() : super(BuyItInitState());
  static BuyItCubit get(context) => BlocProvider.of(context);
}
