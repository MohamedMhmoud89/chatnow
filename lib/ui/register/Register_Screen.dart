import 'package:chatnow/component/Custom_Text_Form_Field.dart';
import 'package:chatnow/utils/validation_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'register_screen';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage('assets/images/login_pattern.png'),
            fit: BoxFit.fill),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create Account'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 210, horizontal: 20),
          child: Column(
            spacing: 30,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextFormField(
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return "Please enter Full name";
                  }
                },
                labelText: "First Name",
                controller: TextEditingController(),
              ),
              CustomTextFormField(
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return "Please enter email";
                  }
                  if (!ValidationUtils.isValidEmail(text)) {
                    return "email bad format";
                  }
                  return null;
                },
                labelText: "E-mail",
                controller: TextEditingController(),
                textInputType: TextInputType.emailAddress,
              ),
              CustomTextFormField(
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return "Please enter Password";
                  }
                  if (text.length < 6) {
                    return "Password should at least 6 chars";
                  }
                  return null;
                },
                labelText: "Password",
                controller: TextEditingController(),
                isPassword: true,
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff303030).withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Create Account',
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Color(0xffBDBDBD),
                            fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Color(0xffBDBDBD),
                        size: 30,
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      backgroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 40)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
