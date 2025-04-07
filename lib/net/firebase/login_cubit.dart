
import 'package:bloc/bloc.dart';

import '../../model/user_model/parent_model.dart';
import '../../model/user_model/tenant_model.dart';

class LoginCubit extends Cubit<ParentRecord> {

  LoginCubit() : super(TenantRecord("", "", 0, ""));
  //switch to a new state
  void toggle(ParentRecord value) => emit(value);
}