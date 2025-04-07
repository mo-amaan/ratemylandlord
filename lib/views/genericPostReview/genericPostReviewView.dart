import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rate_my_landlord/net/firebase/database/selected_cubit.dart';

import '../../../constant.dart';
import '../../model/rating_model/rating_record.dart';
import '../../net/firebase/auth/cubit/authorization_cubit.dart';
import '../../net/firebase/database/rating/cubit/rating_database_cubit.dart';

/*
this view takes an object's header Text and the status
to show on top of the post review page
 */
class PostReviewView extends StatefulWidget {
  final String headerText;
  final String status;
  const PostReviewView(
      {Key? key, required this.headerText, required this.status})
      : super(key: key);

  @override
  _PostReviewViewState createState() => _PostReviewViewState();
}

class _PostReviewViewState extends State<PostReviewView> {

  late final TextEditingController _commentController;


  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();

  }

  @override
  void dispose() {
    _commentController.dispose();

    super.dispose();
  }


  double rating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: Container(
              padding: const EdgeInsets.only(top: 70),
              child: SingleChildScrollView(
                  //padding: EdgeInsets.all(5),
                  child: Column(
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  context.read<SelectedCubit>().state.getName(),
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Align(
                              alignment: Alignment.center,
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 13.0,
                                    color: Color.fromRGBO(108, 117, 125, 1),
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "Status: ",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: context.read<SelectedCubit>().state.getType()),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(136, 106, 106, 106),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                    offset: Offset(7, 7),
                                  ),
                                  BoxShadow(
                                    color: Colors.white60,
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                    offset: Offset(-7, -7),
                                  ),
                                  BoxShadow(
                                    color: Colors.white70,
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                    offset: Offset(14, 14),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Align(
                                    child: Text(
                                      "Rating (Select star to rate)",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w700,
                                        color: greyColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Align(
                                    child: Text(
                                      "$rating",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w700,
                                          color: navyBlueColor,
                                          fontSize: 20),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  RatingBar.builder(
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4),
                                    minRating: 1,
                                    allowHalfRating: true,
                                    updateOnDrag: true,
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: goldenColor,
                                    ),
                                    onRatingUpdate: (rating) => setState(() {
                                      this.rating = rating;
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.only(right: 15, left: 15),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Leave a comment",
                              hintStyle: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15.0,
                                  color: greyColor),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(222, 222, 222, 1.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: goldenColor, width: 2.0),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            maxLength: 2000,
                            maxLines: 6,
                            controller: _commentController,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          child: Text(
                            "Post the review",
                            style: TextStyle(
                                fontFamily: "Poppins", fontSize: 15.0),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: navyBlueColor,
                            minimumSize: const Size.square(50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: () async {
                            String em= await context.read<AuthorizationCubit>().getName();
                            context.read<RatingDatabaseCubit>().postRating(
                                RatingRecord(em,rating.toInt(),_commentController.text.trim(),DateTime.now()),
                            context.read<SelectedCubit>().state.getID());
                            Navigator.pop(context);
                          },
                        ),
                      ])
                    ],
                  )
                ],
              ))),
        ));
  }

  Widget _button(String text) {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(fontFamily: "Poppins", fontSize: 15.0),
      ),
      style: ElevatedButton.styleFrom(
        primary: navyBlueColor,
        minimumSize: const Size.square(50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
