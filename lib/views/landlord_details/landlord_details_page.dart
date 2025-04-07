import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/objectDetails_model/details.dart';
import '../../model/user_model/parent_model.dart';
import '../../net/firebase/database/rating/cubit/rating_database_cubit.dart';
import '../../net/firebase/database/selected_cubit.dart';
import '../../routes/route_generator.dart';
import '../genericDetails/genericDetailsView.dart';

class LandlordDetailsPage extends StatelessWidget {
  LandlordDetailsPage({Key? key}) : super(key: key);
  List<String> photoAlbum = [
    "assets/images/landlordImages/l3.jpg",
    "assets/images/landlordImages/l2.jpg",
    "assets/images/landlordImages/l1.png",
  ];
  String headLineText = "Killam Properties";
  final double rating = 3.5;
  final String status = "Landlord";
  final String commentator = "Afridi";
  final String commentatorStatus = "Tenant";
  final String commentBody = "I lived under this management. Very helpful people.";
  String routeTo = RouteGenerator.postReviewLandlordPage;
  @override
  Widget build(BuildContext context) {
    final objectDetails object = objectDetails(photoAlbum, headLineText, rating, status, commentator, commentatorStatus, commentBody, routeTo);
    return BlocBuilder<SelectedCubit, ParentRecord>(
        builder: (context, state) {
      ParentRecord t= state;
      final objectDetails object = objectDetails(photoAlbum, t.getName(), t.getRating().toDouble() , status, commentator, commentatorStatus, commentBody, routeTo);
      context.read<RatingDatabaseCubit>().fetchRatings(context.read<SelectedCubit>().state.getID());
      return DetailsView(object);
    });
  }
}