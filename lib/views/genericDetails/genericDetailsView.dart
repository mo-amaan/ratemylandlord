import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rate_my_landlord/constant.dart';
import 'package:rate_my_landlord/model/objectDetails_model/details.dart';
import 'package:rate_my_landlord/model/rating_model/rating_record.dart';
import 'package:rate_my_landlord/net/firebase/database/rating/cubit/rating_database_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../net/firebase/database/selected_cubit.dart';
import '../../routes/route_generator.dart';

/*
This view takes a object as a parameter
For example the parameter could be landlord, tenant or address object
Every object has a headline(Name), status(landlord/address/tenant), rating, photoAlbum(list of photo urls), Commentator, commentator status, comment body)
 */
class DetailsView extends StatefulWidget {
  final controller = CarouselController();
  int activeIndex = 0;
  final objectDetails obj;
  DetailsView(this.obj, {Key? key}) : super(key: key);

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
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

    itemCount: widget.obj.photoAlbum.length,
    itemBuilder: (context, index, realIndex){
    final addrsImages = widget.obj.photoAlbum[index];
    return _buildImage(addrsImages, index);
    },
    carouselController: widget.controller,
    options: CarouselOptions(
    //initialPage: 3,
    height: 280,
    //viewportFraction: 1,
    //autoPlay: true,
    //reverse: true,
    enlargeCenterPage: true,
    enlargeStrategy: CenterPageEnlargeStrategy.height,
    onPageChanged: (index, reason) => {
    setState(() => widget.activeIndex = index),
    }
    ),
    ),


    const SizedBox(height: 5,),

    AnimatedSmoothIndicator(
    activeIndex: widget.activeIndex,
    count: widget.obj.photoAlbum.length,
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
    Text(context.read<SelectedCubit>().state.getName(),style: TextStyle(
      fontFamily: "Poppins",
    fontWeight: FontWeight.w900,
    fontSize: 18,

    ),),
    _button("Leave a review", widget.obj.routeTo),
    ],
    ),

    _ratingBar(context.read<SelectedCubit>().state.getRating().toDouble()),

    const SizedBox(height: 10),

    Align(
    alignment: Alignment.topLeft,
    child: RichText(
    text: TextSpan(
    style: const TextStyle(
      fontFamily: "Poppins",
    fontSize: 12.0,
    color: Color.fromRGBO(108, 117, 125,1),
    ),
    children: <TextSpan>[
    TextSpan(text:"Status: " , style: const TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.bold
    )),
    TextSpan(text: context.read<SelectedCubit>().state.getType() ),
    ],
    ),
    ),
    ),


    ],
    ),

    ),

    const SizedBox(height: 20,),

    Align(
    child: Text("Reviews", style: TextStyle(color:navyBlueColor, fontFamily: "Poppins", fontWeight: FontWeight.w800, fontSize: 16),),
    ),

    const SizedBox(height: 20,),
    Container(
      padding: const EdgeInsets.only(top: 50),
      child: BlocBuilder<RatingDatabaseCubit,RatingDatabaseState>(
        builder: (context, state) {
          //context.read<RatingDatabaseCubit>().postRating(RatingRecord("Essayas",5,"He is the best", DateTime.now()));
          return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: state.leaderboard.length,
              itemBuilder: (context, index) {
                RatingRecord hsr = state.leaderboard[index];
                return _commentCard(Icon(FontAwesomeIcons.solidCircleUser,size: 35,), hsr.userNamePersonPostedBy, widget.obj.commentatorStatus, hsr.comment);
              });
        },
      ),
    ),
    ],
    )],
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
                Text(userName, style: TextStyle(color: navyBlueColor, fontFamily: "Poppins", fontWeight: FontWeight.bold),),
                const SizedBox(height: 2,),
                Text(status, style: TextStyle(color: greyColor, fontFamily: "Poppins", fontSize: 11, fontWeight: FontWeight.bold),),

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
            Flexible( child: new Text(commentBody, style: TextStyle(fontSize: 13, fontFamily: "Poppins", fontWeight: FontWeight.w200))) // Flexible used because the line overflows, cross the width of the screen
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
        style: TextStyle(fontFamily: "Poppins", fontSize: 12.0),
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
    margin: EdgeInsets.symmetric( horizontal: 1),
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
    widget.controller.animateToPage(index);
  }
}
