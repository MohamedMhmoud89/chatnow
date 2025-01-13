import 'package:chatnow/Shared_Data.dart';
import 'package:chatnow/database/My_Database.dart';
import 'package:chatnow/firebase/Firebase_Error_Codes.dart';
import 'package:chatnow/model/My_User.dart';
import 'package:chatnow/ui/base/Base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class RegisterNavigator extends BaseNavigator {}

class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  void register(String email, String password, String userName, String fullName,
      context) async {
    try {
      navigator?.showLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      MyUser newUser = MyUser(
          id: credential.user?.uid,
          fullName: fullName,
          userName: userName,
          email: email);
      var insertedUser = await MyDatabase.insertUser(newUser);
      if (insertedUser != null) {
        SharedData.user = insertedUser;
        navigator?.hideLoadingDialog();
        navigator?.showMessageDialog(
          'Register successful',
          postActionName: "Ok",
          postAction: () {
            Navigator.pop(context);
          },
        );
      } else {
        navigator?.hideLoadingDialog();
        navigator?.showMessageDialog('Something went wrong, in database',
            negActionName: "Try again",
            negAction: () =>
                register(email, password, context, userName, fullName),
            postActionName: "Ok");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrorCodes.weakPassword) {
        navigator?.hideLoadingDialog();
        navigator?.showMessageDialog('The password provided is too weak.',
            negActionName: "Ok");
      } else if (e.code == FirebaseErrorCodes.emailInUse) {
        navigator?.hideLoadingDialog();
        navigator?.showMessageDialog(
            'The account already exists for that email.',
            negActionName: "Ok");
      }
    } catch (e) {
      navigator?.hideLoadingDialog();
      navigator?.showMessageDialog('Something went wrong.',
          negActionName: "Try again",
          negAction: () =>
              register(email, password, context, userName, fullName),
          postActionName: "Ok");
    }
  }
}
