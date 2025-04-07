
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rate_my_landlord/constant.dart';

import '../../model/rating_model/rating_record.dart';
import '../../net/firebase/auth/cubit/authorization_cubit.dart';
import '../../net/firebase/database/rating/cubit/rating_database_cubit.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<RatingDatabaseCubit>().fetchRatings(context.read<AuthorizationCubit>().getEmail());
    return Scaffold(
        /*appBar: AppBar(
          centerTitle: true,
          title: const Text("Home Page"),
        ),*/
      backgroundColor: backgroundColor,
      body: Container(
          padding: const EdgeInsets.only(right: 15, left: 15,top: 50),

          child: SingleChildScrollView(
        //padding: EdgeInsets.all(5),
            child: Column(

              children: <Widget>[

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width*0.7,
                    color: lightGreyColor,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Icon(
                      FontAwesomeIcons.userLarge,
                      color: navyBlueColor,
                      size: 250,
                    ),
                  )),

                const SizedBox(height: 20,),

                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(context.read<AuthorizationCubit>().getName(),style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,

                        ),),
                        _button("Edit profile",()=>print("Essayas")),
                        _button("LogOut", ()=>context.read<AuthorizationCubit>().signOut()),
                      ],
                    ),

                    Row(
                      children:  <Widget>[
                        Icon(
                          FontAwesomeIcons.solidStar,
                          color: goldenColor,
                          size: 13,
                        ),
                        Icon(
                          FontAwesomeIcons.solidStar,
                          color: goldenColor,
                          size: 13,
                        ),
                        Icon(
                          FontAwesomeIcons.solidStar,
                          color: goldenColor,
                          size: 13,
                        ),
                        Icon(
                          FontAwesomeIcons.solidStar,
                          color: goldenColor,
                          size: 13,
                        ),
                        Icon(
                          FontAwesomeIcons.solidStar,
                          color: goldenColor,
                          size: 13,
                        )
                      ],
                    ),

                    const SizedBox(height: 6),

                    Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 13.0,
                            color: Color.fromRGBO(108, 117, 125,1),
                          ),
                          children: <TextSpan>[
                            TextSpan(text:"Status: " , style: const TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: context.read<AuthorizationCubit>().getType() ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 4,),

                    Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 13.0,
                            color: Color.fromRGBO(108, 117, 125,1),
                          ),
                          children: <TextSpan>[
                            TextSpan(text:"Member since " , style: const TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: context.read<AuthorizationCubit>().getDateRegistered(), style: const TextStyle(fontStyle: FontStyle.italic) ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),


                const SizedBox(height: 20,),

                Align(
                  child: Text("Reviews", style: TextStyle(color:navyBlueColor, fontWeight: FontWeight.w800, fontSize: 17),),
                ),

                const SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.only(top: 50),
                  child: BlocBuilder<RatingDatabaseCubit,RatingDatabaseState>(
                    builder: (context, state) {
                      //context.read<RatingDatabaseCubit>().postRating(RatingRecord("Essayas",5,"He is the best", DateTime.now()));
                      //context.read<RatingDatabaseCubit>().fetchRatings(context.read<AuthorizationCubit>().getEmail());
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: state.leaderboard.length,
                          itemBuilder: (context, index) {
                            RatingRecord hsr = state.leaderboard[index];
                            return _commentCard(Icon(FontAwesomeIcons.solidCircleUser,size: 35,), hsr.userNamePersonPostedBy,"Tenant", hsr.comment);
                          });
                    },
                  ),
                ),

    ],
    )
    )
    ));
  }

  Widget _button(String text, var fun){
    return FlatButton(
      padding: const EdgeInsets.only(
          left: 15, right: 15),
      child:  Text(
        text,
        style: TextStyle(fontSize: 12.0),
      ),
      color: navyBlueColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)),
      textColor: Colors.white,
      onPressed: fun,
    );
  }

  Widget _commentCard(Icon icon, String userName, String status, String commentBody) {
    return Column(
      children:<Widget>[
        Row(
          children: [
            Container(
              //padding: const EdgeInsets.only(right: 5),
              child:icon,
            ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userName, style: TextStyle(color: navyBlueColor, fontWeight: FontWeight.bold),),
                Text(status, style: TextStyle(color: greyColor, fontSize: 12, fontWeight: FontWeight.bold),),

              ],
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          //margin: const EdgeInsets.only(left: 45),
          children: [
            const SizedBox(width: 40),
            Flexible( child: new Text(commentBody, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300))) // FLexible used because the line overflows, cross the width of the screen
          ],
        ),
        Divider(
            color: Color.fromRGBO(175, 175, 175, 1.0)
        )
      ],
    );
  }
}