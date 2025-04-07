import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rate_my_landlord/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rate_my_landlord/model/user_model/tenant_model.dart';
import 'package:rate_my_landlord/net/firebase/database/landlord/landlord_database_cubit.dart';
import 'package:rate_my_landlord/net/firebase/database/tenant/cubit/tenant_database_cubit.dart';
import 'package:rate_my_landlord/views/search/selected_type_cubit.dart';

import '../../model/rating_model/rating_record.dart';
import '../../model/user_model/landlord_model.dart';
import '../../net/firebase/database/rating/cubit/rating_database_cubit.dart';
import '../../net/firebase/database/selected_cubit.dart';
import '../../net/map/map_cubit.dart';
import '../../routes/route_generator.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
            padding: const EdgeInsets.only(top: 70, left: 15, right: 15),
            child: SingleChildScrollView(
              //padding: EdgeInsets.all(5),
              child: Column(children: <Widget>[
                CupertinoSearchTextField(
                    style: TextStyle(fontFamily: "Poppins", fontSize: 15),
                    padding: const EdgeInsets.all(12),
                    borderRadius: BorderRadius.circular(20),
                    itemColor: goldenColor,
                    onChanged: (s) async => {
                          if(context.read<SelectedTypeCubit>().state==0){
                            context.read<TenantsDatabaseCubit>().searchFilter(s),
                          }
                          else if(context.read<SelectedTypeCubit>().state==1){
                            context.read<LandlordDatabaseCubit>().searchFilter(s),
                          }
                          //context.read<MapCubit>().searchPlaces(s),
                        }),
                const SizedBox(height: 10),
                BlocBuilder<SelectedTypeCubit, int>(
                  builder: (context, state) {
                    if(state==2) {
                      return Container(
                          height: 300.0,
                          child: GoogleMap(
                            mapType: MapType.normal,
                            myLocationEnabled: true,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(46.5107, -63.4168),zoom:8.0,
                            ),
                          ));
                    }
                    return const SizedBox(height: 0);
                  },
                ),
                const SizedBox(height: 10),
                BlocBuilder<TenantsDatabaseCubit, TenantsDatabaseState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _button("Tenant", state.tenantsList.length, true),
                        _button2("Landlord", 0, false),
                        _button3("Address", 0, false),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 30),
                BlocBuilder<SelectedTypeCubit, int>(
                  builder: (context, state) {
                    if (state == 0) {
                      return Container(
                        padding: const EdgeInsets.only(top: 50),
                        child: BlocBuilder<TenantsDatabaseCubit,
                            TenantsDatabaseState>(
                          builder: (context, state) {
                            //context.read<TenantsDatabaseCubit>().addToDatabase(TenantRecord("essayas","kassa",5,"0 unversity avenue"));
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: state.tenantsList.length,
                                itemBuilder: (context, index) {
                                  TenantRecord hsr = state.tenantsList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      context.read<SelectedCubit>().toggle(hsr);
                                      Navigator.pushNamed(context,
                                          RouteGenerator.tenantDetailsPage);
                                    },
                                    child: _card(
                                      const Icon(
                                        FontAwesomeIcons.solidUserCircle,
                                        size: 65,
                                        color: Colors.black,
                                      ),
                                      "${hsr.firstName} ${hsr.lastName}",
                                      "Former tenant at 57H Burns Ave",
                                      hsr.rating.toDouble(),
                                    ),
                                  );
                                });
                          },
                        ),
                      );
                    } else if (state == 1) {
                      return Container(
                        padding: const EdgeInsets.only(top: 50),
                        child: BlocBuilder<LandlordDatabaseCubit,
                            LandlordDatabaseState>(
                          builder: (context, state) {
                            //context.read<TenantsDatabaseCubit>().addToDatabase(TenantRecord("essayas","kassa",5,"0 unversity avenue"));
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: state.landlordsList.length,
                                itemBuilder: (context, index) {
                                  LandLordRecord hsr =
                                      state.landlordsList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      context.read<SelectedCubit>().toggle(hsr);
                                      Navigator.pushNamed(context,
                                          RouteGenerator.tenantDetailsPage);
                                    },
                                    child: _card(
                                      const Icon(
                                        FontAwesomeIcons.solidUserCircle,
                                        size: 65,
                                        color: Colors.black,
                                      ),
                                      "${hsr.firstName} ${hsr.lastName}",
                                      "Former tenant at 57H Burns Ave",
                                      hsr.rating.toDouble(),
                                    ),
                                  );
                                });
                          },
                        ),
                      );
                    } else {
                      return Container(
                        padding: const EdgeInsets.only(top: 50),
                        child: BlocBuilder<TenantsDatabaseCubit,
                            TenantsDatabaseState>(
                          builder: (context, state) {
                            //context.read<TenantsDatabaseCubit>().addToDatabase(TenantRecord("essayas","kassa",5,"0 unversity avenue"));
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: state.tenantsList.length,
                                itemBuilder: (context, index) {
                                  TenantRecord hsr = state.tenantsList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      context.read<SelectedCubit>().toggle(hsr);
                                      Navigator.pushNamed(context,
                                          RouteGenerator.tenantDetailsPage);
                                    },
                                    child: _card(
                                      const Icon(
                                        FontAwesomeIcons.solidUserCircle,
                                        size: 65,
                                        color: Colors.black,
                                      ),
                                      "${hsr.firstName} ${hsr.lastName}",
                                      "Former tenant at 57H Burns Ave",
                                      hsr.rating.toDouble(),
                                    ),
                                  );
                                });
                          },
                        ),
                      );
                    }
                  },
                ),
              ]),
            )));
  }

  Widget _button(String buttonText, int availableResult, bool active) {
    return BlocBuilder<SelectedTypeCubit, int>(builder: (context, state) {
      return ElevatedButton(
        child: Text(
          buttonText +
              "(${context.read<TenantsDatabaseCubit>().state.tenantsList.length})",
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13.0,
              color: context.read<SelectedTypeCubit>().state == 0
                  ? Colors.white
                  : Colors.black,
              fontWeight: FontWeight.w400),
        ),
        style: ElevatedButton.styleFrom(
          primary: context.read<SelectedTypeCubit>().state == 0
              ? navyBlueColor
              : inactiveColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: () {
          context.read<SelectedTypeCubit>().toggle(0);
        },
      );
    });
  }

  Widget _button2(String buttonText, int availableResult, bool active) {
    return BlocBuilder<SelectedTypeCubit, int>(builder: (context, state) {
      return ElevatedButton(
        child: Text(
          buttonText +
              "(${context.read<LandlordDatabaseCubit>().state.landlordsList.length})",
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13.0,
              color: context.read<SelectedTypeCubit>().state == 1
                  ? Colors.white
                  : Colors.black,
              fontWeight: FontWeight.w400),
        ),
        style: ElevatedButton.styleFrom(
          primary: context.read<SelectedTypeCubit>().state == 1
              ? navyBlueColor
              : inactiveColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: () {
          context.read<SelectedTypeCubit>().toggle(1);
        },
      );
    });
  }

  Widget _button3(String buttonText, int availableResult, bool active) {
    return BlocBuilder<SelectedTypeCubit, int>(builder: (context, state) {
      return ElevatedButton(
        child: Text(
          buttonText +
              "(${context.read<TenantsDatabaseCubit>().state.tenantsList.length})",
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13.0,
              color: context.read<SelectedTypeCubit>().state == 2
                  ? Colors.white
                  : Colors.black,
              fontWeight: FontWeight.w400),
        ),
        style: ElevatedButton.styleFrom(
          primary: context.read<SelectedTypeCubit>().state == 2
              ? navyBlueColor
              : inactiveColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: () {
          context.read<SelectedTypeCubit>().toggle(2);
        },
      );
    });
  }

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
      height: 100,
      //color: Colors.white,
      padding: const EdgeInsets.all(15),
      child: Row(
        children: <Widget>[
          Container(
            child: mainIcon,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                header,
                style: const TextStyle(
                    color: Color.fromRGBO(0, 48, 73, 1),
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w900),
              ),
              Text(
                subheader,
                style: const TextStyle(
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
    if (rating > 5) rating = 5;
    double i = 1;
    double maxRate = 5;
    bool flag = true;
    return Row(
      children: <Widget>[
        for (i = 1; i <= rating; i++)
          Icon(
            FontAwesomeIcons.solidStar,
            color: goldenColor,
            size: 13,
          ),
        //if((i-rating) > 0 && (i-rating) < 1)
        for (; (i - rating) > 0 && (i - rating) < 1; i++)
          Icon(
            FontAwesomeIcons.starHalfStroke,
            color: goldenColor,
            size: 13,
          ),
        for (int j = 0; j < (maxRate - i) + 1; j++)
          Icon(
            FontAwesomeIcons.star,
            color: goldenColor,
            size: 13,
          )
      ],
    );
  }
}
