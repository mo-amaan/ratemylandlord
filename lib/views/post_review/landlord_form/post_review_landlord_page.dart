import 'package:flutter/cupertino.dart';

import '../../genericPostReview/genericPostReviewView.dart';

class PostReviewLandlordPage extends StatelessWidget {
  const PostReviewLandlordPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PostReviewView(headerText: "Killam Properties", status: 'Landlord');
  }
}