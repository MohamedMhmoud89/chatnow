import 'package:chatnow/ui/login/Login_Screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = 'splash_screen';

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 4),
      () {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
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
