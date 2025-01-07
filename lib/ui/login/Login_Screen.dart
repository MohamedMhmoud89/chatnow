import 'package:chatnow/component/Custom_Text_Form_Field.dart';
import 'package:chatnow/ui/base/Base.dart';
import 'package:chatnow/ui/login/Login_View_Model.dart';
import 'package:chatnow/ui/register/Register_Screen.dart';
import 'package:chatnow/utils/validation_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen, LoginViewModel>
    implements LoginNavigator {
  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Container(
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
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 210, horizontal: 20),
              child: Form(
                key: formKey,
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
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                    ),
                    CustomTextFormField(
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "Please enter password";
                        }
                        return null;
                      },
                      labelText: "Password",
                      controller: passwordController,
                      isPassword: true,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        login(context);
                        setState(() {});
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
                          padding: EdgeInsets.symmetric(
                              vertical: 18, horizontal: 40)),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RegisterScreen.routeName);
                            },
                            child: Text('Or Create My Account'))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login(context) async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    viewModel.login(emailController.text, passwordController.text, context);
  }
}
