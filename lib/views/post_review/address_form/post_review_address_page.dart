import 'package:flutter/material.dart';

import '../../genericPostReview/genericPostReviewView.dart';


class PostReviewAddressPage extends StatelessWidget {
  const PostReviewAddressPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PostReviewView(headerText: "531D University Avenue", status: 'Address',);
  }
}