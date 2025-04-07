
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rate_my_landlord/net/firebase/database/tenant/tenants_database.dart';
import '../../../../../model/user_model/tenant_model.dart';

part 'tenant_database_state.dart';

class TenantsDatabaseCubit extends Cubit<TenantsDatabaseState> {
  TenantsDatabase db;

  late StreamSubscription subscription;
  late StreamSubscription sub;

  //alter this to take in a db reference in the constructor
  TenantsDatabaseCubit(this.db) : super(TenantsDatabaseState()) {
    fetchTenantsList();
    subscription = db.subscribe(_processEvent);
    sub = db.subscribe2(_processEvent);
  }

  void _processEvent(DatabaseEvent event) {
    final hsMap = event.snapshot.value as Map<dynamic, dynamic>;
    TenantRecord hsr = TenantRecord.fromMap(hsMap);
    addToDatabase2(hsr);
  }
  void addToDatabase2(TenantRecord tenantRecord) {
    fetchTenantsList();
  }

  void addToDatabase(TenantRecord tenantRecord) {
    List<TenantRecord> tenantsList = <TenantRecord>[tenantRecord];
    tenantsList.addAll(state.tenantsList);
    emit(state.copyWith(status: HSStatus.loaded, tenantsList: tenantsList));
    db.addTenant(tenantRecord);
  }

  void searchFilter(String title){
    if(title==""){
      fetchTenantsList();
      return;
    }
    List<TenantRecord> index= state.tenantsList.where((item)=> item.firstName.toUpperCase().contains(title.toUpperCase())).toList();
    emit(state.copyWith( tenantsList: index));
  }

  Future<void> fetchTenantsList() async {
    emit(state.copyWith(status: HSStatus.loading));
    List<TenantRecord> tenantsList = await db.getTenants();
    emit(state.copyWith(status: HSStatus.loaded, tenantsList: tenantsList));
  }

}

