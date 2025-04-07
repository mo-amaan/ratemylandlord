
import 'package:rate_my_landlord/model/user_model/parent_model.dart';

import '../../net/firebase/database/landlord/landlord_database.dart';

class LandLordRecord extends  ParentRecord implements Comparable {

  final String firstName;
  final String lastName;
  final int rating;
  final String emailAddress;

  LandLordRecord(this.firstName, this.lastName, this.rating, this.emailAddress){
    super.type= Type.landlord;
  }

  factory LandLordRecord.fromMap(Map<dynamic, dynamic> map) {
    print("here");
    print(map);
    String firstName = map[LandlordDatabase.firstNameField] as String;
    String lastName = map[LandlordDatabase.lastNameField] as String;
    int rating = map[LandlordDatabase.ratingField] as int;
    String address = map[LandlordDatabase.addressField] as String;
    return LandLordRecord(firstName, lastName, rating, address);
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
    return "Landlord";
  }



}