import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_landlord/model/user_model/parent_model.dart';
import 'package:rate_my_landlord/model/user_model/tenant_model.dart';

class SelectedCubit extends Cubit<ParentRecord> {

  SelectedCubit() : super(TenantRecord("", "", 0, ""));
  //switch to a new state
  void toggle(ParentRecord value) => emit(value);
}