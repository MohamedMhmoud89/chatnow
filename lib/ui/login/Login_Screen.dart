import 'package:chatnow/component/Custom_Text_Form_Field.dart';
import 'package:chatnow/ui/home/Home_Screen.dart';
import 'package:chatnow/ui/register/Register_Screen.dart';
import 'package:chatnow/utils/validation_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login_screen';

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
          title: Text('Login'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 210, horizontal: 20),
          child: Column(
            spacing: 30,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome back!',
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    fontSize: 24, fontWeight: FontWeight.bold),
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
                labelText: "Email",
                controller: TextEditingController(),
                textInputType: TextInputType.emailAddress,
              ),
              CustomTextFormField(
                validator: (text) {},
                labelText: "Password",
                controller: TextEditingController(),
                isPassword: true,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Login',
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    backgroundColor: Theme.of(context).primaryColor,
                    padding:
                        EdgeInsets.symmetric(vertical: 18, horizontal: 40)),
              ),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterScreen.routeName);
                      },
                      child: Text('Or Create My Account'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
