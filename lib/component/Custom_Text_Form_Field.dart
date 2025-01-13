import 'package:flutter/material.dart';

typedef MyValidator = String? Function(String?);

class CustomTextFormField extends StatelessWidget {
  String labelText;
  TextEditingController controller;
  bool isPassword;
  TextInputType textInputType;
  MyValidator? validator;
  int lines;

  CustomTextFormField({this.validator,
      required this.labelText,
      required this.controller,
      this.textInputType = TextInputType.text,
      this.isPassword = false,
      this.lines = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
      ),
      controller: controller,
      obscureText: isPassword,
      keyboardType: textInputType,
      validator: validator,
      maxLines: lines,
      minLines: lines,
    );
  }
}
