import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_landlord/routes/unknown_screen.dart';
import 'package:rate_my_landlord/views/address_details/address_details_page.dart';
import 'package:rate_my_landlord/views/auth/singup_page.dart';
import 'package:rate_my_landlord/views/landlord_details/landlord_details_page.dart';
import 'package:rate_my_landlord/views/post_review/tenant_form/post_review_tenant_page.dart';
import 'package:rate_my_landlord/views/tenant_details/tenant_details_page.dart';
import 'package:rate_my_landlord/views/tenant_details/testRating.dart';

import '../screens/screen.dart';
import '../views/auth/login_page.dart';
import '../views/home/home_page.dart';
import '../views/info/info_page.dart';
import '../views/post_review/address_form/post_review_address_page.dart';
import '../views/post_review/landlord_form/post_review_landlord_page.dart';
import '../views/profile/profile_page.dart';
import '../views/search/search_page.dart';
import 'custom_page_route.dart';

class RouteGenerator {
  static const String homePage = '/';
  static const String signUpPage = 'signUp';
  static const String logInPage = '/logIn';
  static const String profilePage = '/profile';
  static const String searchPage = '/search';
  static const String addressDetailsPage = '/addressDetails';
  static const String tenantDetailsPage = '/tenantDetails';
  static const String landlordDetailsPage = '/landlordDetails';
  static const String postReviewAddressPage = '/postReviewAddress';
  static const String postReviewTenantPage = '/postReviewTenant';
  static const String postReviewLandlordPage = '/postReviewLandlord';
  static const String infoPage = '/info';

  //private constructor
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return CustomPageRoute(
          child: const MainScreen(),
        );
      case logInPage:
        return CustomPageRoute(
          child: const LogInPage(),
        );
      case signUpPage:
        return CustomPageRoute(
          child: const SignUpPage(),
        );
      case profilePage:
        return CustomPageRoute(
          child: const ProfilePage(),
        );
      case searchPage:
        return CustomPageRoute(
          child: const SearchPage(),
        );
      case postReviewAddressPage:
        return CustomPageRoute(
          child: const PostReviewAddressPage(),
        );
      case postReviewTenantPage:
        return CustomPageRoute(
          child: const PostReviewTenantPage(),
        );
      case postReviewLandlordPage:
        return CustomPageRoute(
          child: const PostReviewLandlordPage(),
        );
      case addressDetailsPage:
        return CustomPageRoute(
          child:  AddressDetailsPage(), // changed from const to non const to make it work with Model classes
        );
      case tenantDetailsPage:
        return CustomPageRoute(
          child: TenantDetailsPage(), // changed from const to non const to make it work with Model classes
        );
      case landlordDetailsPage:
        return CustomPageRoute(
          child: LandlordDetailsPage(), // changed from const to non const to make it work with Model classes
        );
      case infoPage:
        return CustomPageRoute(
          child: const InfoPage(),
        );
    }
    if (kDebugMode) {
      return MaterialPageRoute(builder: (context) => UnknownScreen());
    } else {
      return MaterialPageRoute(builder: (context) => const HomePage());
    }
  }
}
/*
    TenantRecord t = context.read<TenanteList>.get(email);
    RatingRecord r= context.read<RatingCubit>.getRating(email);


    active User (t,r )
      tenantrecord
      ratings

     active user
        landlordrecord
        ratings


 */