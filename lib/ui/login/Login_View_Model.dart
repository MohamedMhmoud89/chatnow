import 'package:chatnow/Shared_Data.dart';
import 'package:chatnow/database/My_Database.dart';
import 'package:chatnow/ui/base/Base.dart';
import 'package:chatnow/ui/home/Home_Screen.dart';
import 'package:chatnow/ui/register/Register_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class LoginNavigator extends BaseNavigator {}

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  var auth = FirebaseAuth.instance;

  void login(String email, String password, context) async {
    try {
      navigator?.showLoading();
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      var retrievedUser =
          await MyDatabase.getUserById(credential.user?.uid ?? "");
      if (retrievedUser == null) {
        navigator?.showMessageDialog(
          'User not found in database, please register again',
          postActionName: "Register",
          postAction: () {
            Navigator.pushNamed(context, RegisterScreen.routeName);
          },
        );
      } else {
        SharedData.user = retrievedUser;
        navigator?.hideLoadingDialog();
        navigator?.showMessageDialog(
          'Login successful',
          postActionName: "Ok",
          postAction: () {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      navigator?.hideLoadingDialog();
      navigator?.showMessageDialog(
        'Something went wrong.',
        negActionName: "Ok",
      );
    }
  }
}
