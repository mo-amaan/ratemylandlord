
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rate_my_landlord/constant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../routes/route_generator.dart';

class AddressDetailsView extends StatefulWidget {
  @override
  State<AddressDetailsView> createState() => _AddressDetailsViewState();
}

class _AddressDetailsViewState extends State<AddressDetailsView> {
  final controller = CarouselController();
  int activeIndex = 0;
  final addressImages = [
    "assets/images/addressImages/a1.png",
    "assets/images/addressImages/a2.png",
    "assets/images/addressImages/a3.png",
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.only(top: 50),
    child: SingleChildScrollView(
    //padding: EdgeInsets.all(5),
    child: Column(
      children: <Widget>[
        Column(
          children: [
            CarouselSlider.builder(

              itemCount: addressImages.length,
              itemBuilder: (context, index, realIndex){
                final addrsImages = addressImages[index];
                return _buildImage(addrsImages, index);
              },
              carouselController: controller,
              options: CarouselOptions(
                  //initialPage: 3,
                  height: 280,
                  //viewportFraction: 1,
                  //autoPlay: true,
                  //reverse: true,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index, reason) => {
                    setState(() => activeIndex = index),
                  }
              ),
            ),


            const SizedBox(height: 5,),

            AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: addressImages.length,
              onDotClicked: directToPhoto,
              effect: SwapEffect(
                type: SwapType.yRotation,
                  dotColor: greyColor,
                  activeDotColor: goldenColor,
                  dotWidth: 10,
                  dotHeight: 10,
              ),
            ),

      const SizedBox(height: 20,),

      Container(
        padding: EdgeInsets.only(left: 15, right: 15) ,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("531D University Avenue",style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,

                ),),
                _button("Leave a review",RouteGenerator.postReviewAddressPage),
              ],
            ),

            _ratingBar(4.5),

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
                    TextSpan(text: "Address" ),
                  ],
                ),
              ),
            ),


          ],
        ),

      ),

          const SizedBox(height: 20,),

          Align(
            child: Text("Reviews", style: TextStyle(color:navyBlueColor, fontWeight: FontWeight.w800, fontSize: 17),),
          ),

          const SizedBox(height: 20,),

            Container(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: _commentCard(Icon(FontAwesomeIcons.solidCircleUser,size: 35,), "Afridi Rahman", "Tenant", "Very nice place to live as a student"),
            ),
            Container(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: _commentCard(Icon(FontAwesomeIcons.solidCircleUser,size: 35,), "Shafi Nayan", "Tenant", "Close to school. Don't need to move much"),
            ),
            Container(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: _commentCard(Icon(FontAwesomeIcons.solidCircleUser,size: 35,), "Ram Saha", "Tenant", "Very nice girls around here"),
            ),
      ],
    )]
    )
      ),
    ));
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(userName, style: TextStyle(color: navyBlueColor, fontWeight: FontWeight.bold),),
                const SizedBox(height: 2,),
                Text(status, style: TextStyle(color: greyColor, fontSize: 12, fontWeight: FontWeight.bold),),

              ],
            )
          ],
        ),
        const SizedBox(height: 2,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          //margin: const EdgeInsets.only(left: 45),
          children: [
            const SizedBox(width: 40),
            Flexible( child: new Text(commentBody, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300))) // FLexible used because the line overflows, cross the width of the screen
          ],
        ),
        const SizedBox(height: 10,),
        Divider(
            color: Color.fromRGBO(175, 175, 175, 1.0)
        )
      ],
    );
  }

  Widget _button(String text,String route){
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
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
    );
  }


  Widget _buildImage(String urlImage, int index) => Container(
    margin: EdgeInsets.symmetric( horizontal: 4),
    color: greyColor,
    child: Image.asset(
      urlImage,
      fit: BoxFit.cover,
    ),
  );

  Widget _ratingBar(double rating) {
    if(rating > 5) rating  = 5;
    double i = 1;
    double maxRate = 5;
    bool flag = true;
    return Row(
      children: <Widget>[
        for(i = 1; i<=rating ; i++)
          Icon(
            FontAwesomeIcons.solidStar,
            color: goldenColor,
            size: 13,
          ),
        //if((i-rating) > 0 && (i-rating) < 1)
        for(;(i-rating)>0 && (i-rating) <1;i++)
          Icon(
            FontAwesomeIcons.starHalfStroke,
            color: goldenColor,
            size: 13,
          ),
        for(int j = 0; j< (maxRate-i) + 1; j++)
          Icon(
            FontAwesomeIcons.star,
            color: goldenColor,
            size: 13,
          )
      ],


    );
    /*for(int i = 0; i<rating ; i++) {

    }*/
  }

  void directToPhoto(int index) {
    controller.animateToPage(index);
  }

}