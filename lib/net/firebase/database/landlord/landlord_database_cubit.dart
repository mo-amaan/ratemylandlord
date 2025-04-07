import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:rate_my_landlord/net/firebase/database/landlord/landlord_database.dart';

import '../../../../model/user_model/landlord_model.dart';

part 'landlord_database_state.dart';

class LandlordDatabaseCubit extends Cubit<LandlordDatabaseState> {
  LandlordDatabase db;

  late StreamSubscription subscription;
  late StreamSubscription sub;

  //alter this to take in a db reference in the constructor
  LandlordDatabaseCubit(this.db) : super(LandlordDatabaseState()) {
    fetchTenantsList();
    subscription = db.subscribe(_processEvent);
    sub = db.subscribe2(_processEvent);
  }

  void _processEvent(DatabaseEvent event) {
    final hsMap = event.snapshot.value as Map<dynamic, dynamic>;
    LandLordRecord hsr = LandLordRecord.fromMap(hsMap);
    addToDatabase2(hsr);

  }
  void addToDatabase2(LandLordRecord landLordRecord) {
    fetchTenantsList();
  }

  void addToDatabase(LandLordRecord landLordRecord) {
    List<LandLordRecord> landlordList = <LandLordRecord>[landLordRecord];
    landlordList.addAll(state.landlordsList);
    db.addLandlord(landLordRecord);
    emit(state.copyWith(status: HSStatus.loaded, tenantsList: landlordList));
  }

  void searchFilter(String title){
    if(title==""){
      fetchTenantsList();
      return;
    }
    List<LandLordRecord> index= state.landlordsList.where((item)=> item.firstName.toUpperCase().contains(title.toUpperCase())).toList();
    emit(state.copyWith( tenantsList: index));
  }

  Future<void> fetchTenantsList() async {
    emit(state.copyWith(status: HSStatus.loading));
    List<LandLordRecord> tenantsList = await db.getLandlords();
    emit(state.copyWith(status: HSStatus.loaded, tenantsList: tenantsList));
  }

}