//lib/home/home_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rate_my_landlord/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../routes/route_generator.dart';
import '../../screens/cubit/bottom_nav_bar_cubit.dart';

/// Show the high score
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
            padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
            child: SingleChildScrollView(
              //padding: EdgeInsets.all(5),
              child: Column(children: <Widget>[
                SvgPicture.asset(
                  "assets/illustrations/homepageIllustration.svg",
                  height: 200,
                ),
                //Image.asset("assets/illustrations/homePage.png"),
                const SizedBox(height: 10),
                const Text(
                  "Check ratings before making decision",
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.171875,
                    fontSize: 19.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: goldenColor,

                    /* letterSpacing: 0.0, */
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: const Text(
                    "This is just for example This is just for example This is j just for example This is just for example This is just for example",
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.2,
                      fontSize: 13.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,

                      /* letterSpacing: 0.0, */
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                Container(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: const Text(
                    "Top Rated places around you",
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.2,
                      fontSize: 19.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: navyBlueColor,

                      /* letterSpacing: 0.0, */
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                GestureDetector(
                  onTap: () {},
                  child: _card(
                      const Icon(
                        FontAwesomeIcons.house,
                        size: 55,
                        color: Colors.black,
                      ),
                      "57H Burns Avenue",
                      "C1E 2G4",
                      5),
                ),

                const SizedBox(height: 10),

                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteGenerator.addressDetailsPage);
                  },
                  child: _card(
                      const Icon(
                        FontAwesomeIcons.house,
                        size: 55,
                        color: Colors.black,
                      ),
                      "531D University Avenue",
                      "C1A 9S3",
                      5),
                ),

                const SizedBox(height: 30),

                ElevatedButton(
                  child: const Text(
                    'Browse more',
                    style: TextStyle(fontSize: 17.0, fontFamily: 'Poppins'),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: navyBlueColor,
                    minimumSize: const Size.fromHeight(60), //set only the heights, and set width to full screen
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    // Navigator.pushNamed(context, RouteGenerator.searchPage);
                    //! index 1 is the search page
                    // TODO: have some enum or variable instead of passing int value
                    context.read<BottomNavBarCubit>().setBottomNavBarIndex(1);
                  },
                ),
                const SizedBox(height: 30),
              ]),
            )));


  }

  /*
  This _card widget returns a card with :
  icon(mainIcon), address name(header), address postal code(subheader), rating
   */

  Widget _card(Icon mainIcon, String header, String subheader, double rating) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(136, 106, 106, 106),
            blurRadius: 2,
            offset: Offset(-1, 1),
          ),
        ],
      ),
      height: 90,
      padding: const EdgeInsets.all(15),
      child: Row(
        children: <Widget>[
          Container(
            child: mainIcon,
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                header,
                style: const TextStyle(
                    fontFamily: "Poppins",
                    color: Color.fromRGBO(0, 48, 73, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.w900),
              ),
              Text(
                subheader,
                style:TextStyle(
                    color: subHeaderColor,
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    fontWeight: FontWeight.w600),
              ),

              _ratingBar(rating),
            ],
          )
        ],
      ),
    );
  }


  /*
  This rating bar returns a number of star rated out of 5
  based on the parameter sent to it
   */
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

  }
}
