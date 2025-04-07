import 'package:bloc/bloc.dart';

class SelectedTypeCubit extends Cubit<int> {

  SelectedTypeCubit() : super(0);
  //switch to a new state
  void toggle(int value) => emit(value);
}