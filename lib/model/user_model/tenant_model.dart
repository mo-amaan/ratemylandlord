
import 'package:equatable/equatable.dart';
import 'package:rate_my_landlord/model/user_model/parent_model.dart';

import '../../net/firebase/database/tenant/tenants_database.dart';

class TenantRecord extends Equatable with ParentRecord implements Comparable {

  final String firstName;
  final String lastName;
  final int rating;
  final String emailAddress;

   TenantRecord(this.firstName, this.lastName, this.rating, this.emailAddress){
      super.type= Type.tenant;
  }

  factory TenantRecord.fromMap(Map<dynamic, dynamic> map) {
    print("here");
    print(map);
    String firstName = map[TenantsDatabase.firstNameField] as String;
    String lastName = map[TenantsDatabase.lastNameField] as String;
    int rating = map[TenantsDatabase.ratingField] as int;
    String address = map[TenantsDatabase.addressField] as String;
    return TenantRecord(firstName, lastName, rating, address);
  }

  @override
  int compareTo(other) {
    //longest streaks and equal streaks organized by first occurring
    return 0;
  }

  @override
  List<Object?> get props => [firstName, lastName, rating, emailAddress];

  @override
  String getID() {
    return emailAddress;
  }

  @override
  int getRating() {
    return rating;
  }

  @override
  String getName() {
    return "${firstName} ${lastName}";
  }

  @override
  String getType() {
    return "Tenant";
  }



}