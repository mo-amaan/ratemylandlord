import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_landlord/net/firebase/database/rating/cubit/rating_database_cubit.dart';

import '../../model/objectDetails_model/details.dart';
import '../../model/rating_model/rating_record.dart';
import '../../model/user_model/parent_model.dart';
import '../../model/user_model/tenant_model.dart';
import '../../net/firebase/database/selected_cubit.dart';
import '../../net/firebase/database/tenant/cubit/tenant_database_cubit.dart';
import '../../routes/route_generator.dart';
import '../genericDetails/genericDetailsView.dart';

class TenantDetailsPage extends StatelessWidget {
  TenantDetailsPage({Key? key}) : super(key: key);
  List<String> photoAlbum = [
    "assets/images/tenantImages/t3.jpg",
    "assets/images/tenantImages/t2.png",
    "assets/images/tenantImages/t1.jpg",
  ];
  String headLineText = "Chandler Bing";
  final double rating = 5;
  final String status = "Tenant";
  final String commentator = "Joey";
  final String commentatorStatus = "Tenant";
  final String commentBody = "I lived with him, he paid for my utilities.";
  String routeTo = RouteGenerator.postReviewTenantPage;
  @override
  Widget build(BuildContext context) {
    //context.read<RatingDatabaseCubit>().postRating(RatingRecord("essayas","essayas",5,"He is the best",DateTime.now()));

    return BlocBuilder<SelectedCubit, ParentRecord>(
          builder: (context, state) {
                  ParentRecord t= state;
                  final objectDetails object = objectDetails(photoAlbum, t.getName(), t.getRating().toDouble() , status, commentator, commentatorStatus, commentBody, routeTo);
                  context.read<RatingDatabaseCubit>().fetchRatings(context.read<SelectedCubit>().state.getID());
                  return DetailsView(object);
          },
);
  }
}
