import 'package:bloc/bloc.dart';

class BottomNavBarCubit extends Cubit<int> {
  BottomNavBarCubit(int index) : super(index);
  static const int home = 0;
  static const int search = 1;
  static const int info = 2;
  static const int profile = 3;

  void setBottomNavBarIndex(int index) => emit(index);
}
