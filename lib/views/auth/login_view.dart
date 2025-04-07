
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_landlord/net/firebase/database/tenant/tenants_database.dart';

import '../../constant.dart';
import '../../model/rating_model/rating_record.dart';
import '../../net/firebase/auth/cubit/authorization_cubit.dart';

import '../../net/firebase/login_cubit.dart';
import '../../routes/route_generator.dart';

class LogInView extends StatefulWidget {
  const LogInView({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LogInView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    TenantsDatabase t= TenantsDatabase();

    if(t.ref!=null) {
      print("you are on the right track ");
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        padding:
        const EdgeInsets.only(left: 20, right: 20, top: 35, bottom: 25),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 50),

          Image.asset("assets/images/LoginPageImage.svg.png"),

          const SizedBox(height: 15),

          TextFieldContainer(
            child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.person, color: Colors.grey),
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none)),
          ),
          TextFieldContainer(
              child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey),
                    icon: Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
                    suffixIcon: Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  ))),
          SizedBox(
            width: size.width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(243, 249, 250, 1)),
                    ),
                    onPressed: () => print("trouble loggin in"),
                    child: const Text('Trouble Logging In?'))
              ],
            ),
          ),
          SizedBox(
            width: size.width * 0.8,
            child: ElevatedButton(
              onPressed: () =>
              {
                context.read<AuthorizationCubit>().signIn(
                    emailController.text.trim(), passwordController.text.trim()),
              },
              child: const Text(
                "Log In",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                primary: navyBlueColor,
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
              width: size.width * 0.8,
              child: const Text(
                "Don't have an account? ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: navyBlueColor,
                ),
                textAlign: TextAlign.center,
              )),
          const SizedBox(height: 15),
          SizedBox(
            width: size.width * 0.8,
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                RouteGenerator.signUpPage,
              ),
              child: const Text(
                "Sign Up",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                primary: goldenColor,
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: size.width * 0.8,
            child: Row(children: <Widget>[
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                    child: const Divider(
                      color: Colors.black,
                      height: 36,
                    )),
              ),
              const Text("OR"),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                    child: const Divider(
                      color: Colors.black,
                      height: 36,
                    )),
              ),
            ]),
          ),
          SizedBox(
            width: size.width * 0.8,
            child: ElevatedButton(
              onPressed: (){},
              child: const Text(
                "Login with google",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 15),
                primary: Colors.white,
              ),
            ),
          )
          // const SizedBox(height: 15),
          // SizedBox(
          //   width: size.width * 0.8,
          //   child: SignInButton(
          //     Buttons.FacebookNew,
          //     onPressed: () {},
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(30)),
          //   ),
          // )
        ],
          ),
      ),
    );
  }


}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: lightGreyColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
