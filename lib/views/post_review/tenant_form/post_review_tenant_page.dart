import 'package:flutter/material.dart';
import '../../genericPostReview/genericPostReviewView.dart';


class PostReviewTenantPage extends StatelessWidget {
  const PostReviewTenantPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PostReviewView(headerText: "Essayas Kassa", status: 'Address',);
  }
}