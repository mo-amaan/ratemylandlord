

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:rate_my_landlord/model/user_model/tenant_model.dart';

class TenantsDatabase {
  //the real-time database
  late final DatabaseReference ref;

  static const String _leaders = "tenants";

  static String firstNameField = "firstName";
  static String lastNameField = "lastName";
  static String ratingField = "rating";
  static String addressField = "email";


  //pass this in the constructor to allow for future testing / mocking
  TenantsDatabase({ref})
      : this.ref=ref ?? FirebaseDatabase.instance.ref(_leaders);


  void addTenant(TenantRecord r) {

    DatabaseReference ratingList = ref.push();
    ratingList.set({
      firstNameField: r.firstName,
      lastNameField:r.lastName,
      ratingField: r.rating,
      addressField: r.emailAddress,
    });
  }


  Future<List<TenantRecord>> getTenants() async {
    final tenants = <TenantRecord>[];

    final list = await ref.get();
    if (list.exists) {
      for (final tenant in list.children) {
        final hsMap = tenant.value as Map<dynamic, dynamic>;
        tenants.insert(0, TenantRecord.fromMap(hsMap));
      }
    }
    return tenants;
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