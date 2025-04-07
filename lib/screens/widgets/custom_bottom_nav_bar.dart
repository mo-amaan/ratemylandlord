import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_landlord/screens/cubit/bottom_nav_bar_cubit.dart';

import '../../constant.dart';

/// this is custom navigation bar for our app. It uses the BottomNavBarCubit for managing the currentIndex, selectedIndex and So on.
class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, int>(builder: (context, state) {
      int currentIndex = state;
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (int index) =>
            context.read<BottomNavBarCubit>().setBottomNavBarIndex(index),
        selectedIconTheme:
            const IconThemeData(color: goldenColor, opacity: 1, size: 30),
        unselectedIconTheme:
            const IconThemeData(color: whiteColor, opacity: 0.5, size: 25),
        selectedItemColor: navyBlueColor,
        unselectedItemColor: whiteColor.withOpacity(0.5),
        backgroundColor: navyBlueColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          // BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "feed"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "info"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile"),

          /// this is if the user is logged in and has a profile picture
          // BottomNavigationBarItem(
          //     icon: CircleAvatar(
          //       radius: 14,
          //       backgroundColor: Colors.black,
          //     ),
          //     label: "profile"),
        ],
      );
    });
  }
}
