
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rate_my_landlord/views/address_details/address_details_page.dart';
import '../../../../../model/rating_model/rating_record.dart';
import '../rating_database.dart';

part  'rating_database_state.dart';

class RatingDatabaseCubit extends Cubit<RatingDatabaseState> {
  RatingDatabase db;

  late StreamSubscription subscription;
  late StreamSubscription sub;

  //alter this to take in a db reference in the constructor
  RatingDatabaseCubit(this.db) : super(RatingDatabaseState()) {
    //fetchHighScores();
    //subscription = db.subscribe(_processEvent);
    //sub = db.subscribe2(_processEvent);
  }

  void _processEvent(DatabaseEvent event) {
    final rtMap = event.snapshot.value as Map<dynamic, dynamic>;
    print(rtMap);
    RatingRecord rr = RatingRecord.fromMap(rtMap);
    addRating(rr);
  }

  void addRating(RatingRecord ratingRecord) {
    List<RatingRecord> leaders = <RatingRecord>[ratingRecord];
    leaders.addAll(state.leaderboard);
    emit(state.copyWith(status: HSStatus.loaded, leaderboard: leaders));
  }

  Future<void> fetchRatings(String email) async {
    emit(state.copyWith(status: HSStatus.loading));
    List<RatingRecord> ratingList = await db.getRating(email);
    emit(state.copyWith(status: HSStatus.loaded, leaderboard: ratingList));
  }

  void postRating(RatingRecord r,String email) {
    List<RatingRecord> leaders = <RatingRecord>[r];
    leaders.addAll(state.leaderboard);
    emit(state.copyWith(status: HSStatus.loaded, leaderboard: leaders));
    db.postRating(r,email);
  }

  void filterScores(String title) {

  }
}
/*
      rating cubit

      tentate id
      landlor id


     listtenate cubit

     listlandlord cubit

     listaddress cubit

========================
tenants
  ->essayas@gmail.com
    ->profile          -> ratings
     - fir
     - fdfdfd
========================







 */