
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:rate_my_landlord/model/user_model/landlord_model.dart';

class LandlordDatabase {
  //the real-time database
  late final DatabaseReference ref;

  static const String _leaders = "landlord";

  static String firstNameField = "firstName";
  static String lastNameField = "lastName";
  static String ratingField = "rating";
  static String addressField = "email";


  //pass this in the constructor to allow for future testing / mocking
  LandlordDatabase({ref})
      : this.ref=ref ?? FirebaseDatabase.instance.ref(_leaders);


  void addLandlord(LandLordRecord r) {

    DatabaseReference ratingList = ref.push();
    ratingList.set({
      firstNameField: r.firstName,
      lastNameField:r.lastName,
      ratingField: r.rating,
      addressField: r.emailAddress,
    });
  }


  Future<List<LandLordRecord>> getLandlords() async {
    final landlords = <LandLordRecord>[];

    final list = await ref.get();
    if (list.exists) {
      for (final landlord in list.children) {
        final hsMap = landlord.value as Map<dynamic, dynamic>;
        landlords.insert(0, LandLordRecord.fromMap(hsMap));
      }
    }
    return landlords;
  }

  StreamSubscription subscribe(Function(DatabaseEvent event) fn) {
    return ref
        .orderByChild(ratingField)
        .onChildAdded
        .listen(fn);
  }

  StreamSubscription subscribe2(Function(DatabaseEvent event) fn) {
    return ref
        .orderByChild(ratingField)
        .onChildChanged
        .listen(fn);
  }
}