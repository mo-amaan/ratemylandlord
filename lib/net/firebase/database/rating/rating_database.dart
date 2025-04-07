import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

import '../../../../model/rating_model/rating_record.dart';


class RatingDatabase {

  //the real-time database
  late final DatabaseReference ref;

  static const String _leaders = "rating";

  static String userNamePersonPostedByField = "postByUserName";
  static String ratingField = "rating";
  static String commentField = "comment";
  static String dateField = "date";

  //pass this in the constructor to allow for future testing / mocking
  RatingDatabase({ref})
      : this.ref=ref ?? FirebaseDatabase.instance.ref(_leaders);

  //add rating
  void postRating(RatingRecord r,String email) {
    DatabaseReference ratingList = ref.child(email.replaceAll(".", "@")).push();
    ratingList.set({
      userNamePersonPostedByField: r.userNamePersonPostedBy,
      ratingField: r.rating,
      commentField: r.comment,
      dateField: r.date.millisecondsSinceEpoch
    });
  }

  //retrieve high scores from our database
  Future<List<RatingRecord>> getRating(String email) async {
    final ratings = <RatingRecord>[];
    //top 10 leaders

    final topLeaders = await ref.child(email.replaceAll(".", "@")).get();
    if (topLeaders.exists) {
      for (final rating in topLeaders.children) {
        final hsMap = rating.value as Map<dynamic, dynamic>;
        ratings.insert(0, RatingRecord.fromMap(hsMap));
      }
    }
    return ratings;
  }


  StreamSubscription subscribe(Function(DatabaseEvent event) fn) {
    return ref
        .orderByChild(ratingField)
        .limitToLast(10)
        .onChildAdded
        .listen(fn);
  }

  StreamSubscription subscribe2(Function(DatabaseEvent event) fn) {
    return ref
        .orderByChild(ratingField)
        .limitToLast(10)
        .onChildChanged
        .listen(fn);
  }
}