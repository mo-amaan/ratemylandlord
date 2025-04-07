import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rate_my_landlord/constant.dart';
import 'package:rate_my_landlord/model/objectDetails_model/details.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../model/rating_model/rating_record.dart';
import '../../net/firebase/database/rating/cubit/rating_database_cubit.dart';
import '../../routes/route_generator.dart';

/*
This view takes a object as a parameter
For example the parameter could be landlord, tenant or address object
Every object has a headline(Name), status(landlord/address/tenant), rating, photoAlbum(list of photo urls), Commentator, commentator status, comment body)
 */


class CheckView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.only(top: 50),
        child: BlocBuilder<RatingDatabaseCubit, RatingDatabaseState>(
          builder: (context, state) {
            return ListView.builder(
                itemCount: state.leaderboard.length,
                itemBuilder: (context, index) {
                  RatingRecord hsr =
                  state.leaderboard[index];
                  return Card(
                      child: Padding(
                          padding: const EdgeInsets.all((20.0)),
                          child: ListTile(
                            leading: Icon(Icons.star),
                            title: Center(
                              child: Text(
                                  "${hsr.userNamePersonPostedBy}: ${hsr.comment}"),
                            ),
                            trailing: Icon(Icons.star),
                          )));
                });
          },
        ),
      ),
    );
  }
  }
