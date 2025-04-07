import 'package:flutter/material.dart';
import 'package:rate_my_landlord/constant.dart';
import 'package:rate_my_landlord/routes/route_generator.dart';

class RateApp extends MaterialApp {
  RateApp({Key? key})
      : super(
          key: key,
          initialRoute: RouteGenerator.logInPage,
          onGenerateRoute: RouteGenerator.generateRoute,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // primarySwatch: Colors.green,
            primaryColor: navyBlueColor,
            scaffoldBackgroundColor: backgroundColor,
          ),
        );
}
