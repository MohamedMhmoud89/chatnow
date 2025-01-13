import 'package:chatnow/Shared_Data.dart';
import 'package:chatnow/database/My_Database.dart';
import 'package:chatnow/ui/home/Home_Screen.dart';
import 'package:chatnow/ui/login/Login_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = 'splash_screen';
  var auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 4),
      () async {
        if (auth.currentUser != null) {
          var retrievedUser =
              await MyDatabase.getUserById(auth.currentUser?.uid ?? "");
          SharedData.user = retrievedUser;
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        } else {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        }
      },
    );
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Center(
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }
}
