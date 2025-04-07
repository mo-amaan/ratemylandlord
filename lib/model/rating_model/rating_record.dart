
import 'package:equatable/equatable.dart';
import 'package:rate_my_landlord/model/user_model/parent_model.dart';
import 'package:rate_my_landlord/net/firebase/database/rating/rating_database.dart';


class RatingRecord extends Equatable implements Comparable {

  final String userNamePersonPostedBy;
  final int rating;
  final String comment;
  final DateTime date;
  const RatingRecord(this.userNamePersonPostedBy, this.rating, this.comment, this.date);

  factory RatingRecord.fromMap(Map<dynamic, dynamic> map) {
    String userNamePersonPostedBy= map[RatingDatabase.userNamePersonPostedByField] as String;
    int rating= map[RatingDatabase.ratingField] as int;
    String comment= map[RatingDatabase.commentField] as String;
    int msFromEpoc = map[RatingDatabase.dateField] as int;
    DateTime date = DateTime.fromMillisecondsSinceEpoch(msFromEpoc);
    return RatingRecord(userNamePersonPostedBy, rating, comment, date);
  }


  @override
  int compareTo(other) {
    //longest streaks and equal streaks organized by first occurring
    return 0;
  }

  @override
  List<Object?> get props => [ rating, date];
}