import 'package:flutter/material.dart';
import 'package:rate_my_landlord/routes/route_generator.dart';
import 'package:rate_my_landlord/views/genericDetails/genericDetailsView.dart';

import '../../model/objectDetails_model/details.dart';
import 'address_details_view.dart';

class AddressDetailsPage extends StatelessWidget {
   AddressDetailsPage({Key? key}) : super(key: key);
   List<String> photoAlbum = [
     "assets/images/addressImages/a1.png",
     "assets/images/addressImages/a2.png",
     "assets/images/addressImages/a3.png",
  ];
  String headLineText = "531D University Avenue";
  final double rating = 5;
  final String status = "Address";
  final String commentator = "Sayem Saz";
   final String commentatorStatus = "Tenant";
   final String commentBody = "I live in Toronto now";
   String routeTo = RouteGenerator.postReviewAddressPage;

  @override
  Widget build(BuildContext context) {
    final objectDetails object = objectDetails(photoAlbum, headLineText, rating, status, commentator, commentatorStatus, commentBody, routeTo);
    return DetailsView(object);
  }
}