import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rate_my_landlord/constant.dart';
import 'package:rate_my_landlord/model/user_model/landlord_model.dart';
import 'package:rate_my_landlord/net/firebase/database/landlord/landlord_database_cubit.dart';

import '../../model/user_model/tenant_model.dart';
import '../../net/firebase/auth/cubit/authorization_cubit.dart';
import '../../net/firebase/database/tenant/cubit/tenant_database_cubit.dart';
import '../../net/firebase/login_cubit.dart';
import '../../routes/route_generator.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  final formKey = GlobalKey<FormState>();


  final List<DropdownMenuItem> dropDownItems = const [
    DropdownMenuItem(child: Text("Landlord"), value: "Landlord"),
    DropdownMenuItem(child: Text("Tenant"), value: "Tenant"),
  ];

  String accountType = "";

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future registerUser() async{
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:(context) => Center(child: CircularProgressIndicator())
    );

    print(_firstNameController.text.toString());
    print(accountType);
    var res= await context.read<AuthorizationCubit>().register(_emailController.text.trim(),
        _passwordController.text.trim());
    Navigator.pop(context);
    if(res!="Success") {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) =>
              AlertDialog(
                title: Text("Sign up failed"),
                content: Text(res),
                actions: [TextButton(onPressed: () {
                  Navigator.of(context).pop();
                }, child: Text('ok'),)
                ],
              )
      );
    }
    if(res=="Success") {
      print("Success "+accountType);
      if(accountType=="Tenant") {
         context.read<TenantsDatabaseCubit>().addToDatabase(
            TenantRecord(
                _firstNameController.text.trim(),
                _lastNameController.text.trim(),
                -1, _emailController.text.trim()));
        /*
         context.read<LoginCubit>().toggle(TenantRecord(
            _firstNameController.text.trim(),
            _lastNameController.text.trim(),
            -1, _emailController.text.trim()));

         */
        await context.read<AuthorizationCubit>().setData("Tenant",
            "${_firstNameController.text.trim()} ${_lastNameController.text.trim()}");
      }
      else if(accountType=="Landlord"){
         context.read<LandlordDatabaseCubit>().addToDatabase(
            LandLordRecord(
                _firstNameController.text.trim(),
                _lastNameController.text.trim(),
                -1, _emailController.text.trim()));
        /*
        context.read<LoginCubit>().toggle(LandLordRecord(
            _firstNameController.text.trim(),
            _lastNameController.text.trim(),
            -1, _emailController.text.trim()));

         */
        await context.read<AuthorizationCubit>().setData("Landlord",
            "${_firstNameController.text.trim()} ${_lastNameController.text.trim()}");
      }
      Navigator.pushNamed(
        context,
        RouteGenerator.homePage,
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                SvgPicture.asset(
                  'assets/illustrations/signup.svg',
                  height: 200,
                ),
                TextFieldContainer(
                  child: TextFormField(
                    controller: _firstNameController,

                    decoration: const InputDecoration(
                      hintText: "First Name",
                      hintStyle: TextStyle(color: subHeaderColor),
                      border: InputBorder.none,
                    ),
                      validator: (value) {
                        if(value == null  || value=="") {
                          return "Name can't be empty";
                        }
                        return null;
                      }

                  ),

                ),

                TextFieldContainer(
                  child: TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      hintText: "Last Name",
                      hintStyle: TextStyle(color: subHeaderColor),
                      border: InputBorder.none,
                    ),
                      validator: (value) {
                        if(value == null  || value=="") {
                          return "Name can't be empty";
                        }
                        return null;
                      }
                  ),
                ),
                TextFieldContainer(
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: "Your Email",
                      hintStyle: TextStyle(color: subHeaderColor),
                      border: InputBorder.none,
                    ),
                    validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                      ? 'Enter a valid email' : null,
                  ),
                ),
                TextFieldContainer(
                  child: DropdownButtonFormField(
                    items: dropDownItems,
                    decoration: const InputDecoration(
                      hintText: "Select Status",
                      hintStyle: TextStyle(color: subHeaderColor),
                      border: InputBorder.none,
                    ),
                    onChanged: (dynamic newValue) {
                      setState(() {
                        accountType = newValue! as String;
                      });
                    },
                  ),
                ),
                TextFieldContainer(
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: subHeaderColor),
                      border: InputBorder.none,
                    ),
                    validator: (pass) {
                      if(pass != null && pass.length < 6) {
                        return "Min 6 characters";
                      }
                        return null;
                    }
                  ),
                ),
                TextFieldContainer(
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Confrim Password",
                      hintStyle: TextStyle(color: subHeaderColor),
                      border: InputBorder.none,
                    ),
                      validator: (pass) {
                         if(pass!=_passwordController.text.trim()){
                          return "Passwords don't match";
                        }
                        return null;
                      }
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: registerUser,
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      primary: goldenColor,
                    ),
                  ),
                )
              ],
            ),
          ),
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
