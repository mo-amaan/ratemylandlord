import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_landlord/screens/widgets/custom_bottom_nav_bar.dart';
import '../views/home/home_page.dart';
import '../views/info/info_page.dart';
import '../views/profile/profile_page.dart';
import '../views/search/search_page.dart';
import 'cubit/bottom_nav_bar_cubit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _pages = <Widget>[
    const HomePage(),
    const SearchPage(),
    const InfoPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavBarCubit, int>(
        builder: (context, state) {
          int currentIndex = state;
          return PageTransitionSwitcher(
            transitionBuilder: ((child, primaryAnimation, secondaryAnimation) =>
                SharedAxisTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                  child: child,
                )),
            child: _pages[currentIndex],
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
