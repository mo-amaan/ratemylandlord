import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_landlord/screens/main_screen.dart';

import '../home/home_page.dart';
import 'login_view.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return const MainScreen();
          }
          else {
            return const LogInView();
          }
        }
    );
  }
}