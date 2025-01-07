import 'package:chatnow/component/Custom_Text_Form_Field.dart';
import 'package:chatnow/ui/base/Base.dart';
import 'package:chatnow/ui/register/Register_View_Model.dart';
import 'package:chatnow/utils/validation_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseState<RegisterScreen, RegisterViewModel>
    implements RegisterNavigator {
  var formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  RegisterViewModel initViewModel() {
    return RegisterViewModel();
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
            title: Text('Create Account'),
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
                    CustomTextFormField(
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "Please enter Full name";
                        }
                      },
                      labelText: "User Name",
                      controller: userNameController,
                    ),
                    CustomTextFormField(
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "Please enter Full name";
                        }
                      },
                      labelText: "Full Name",
                      controller: fullNameController,
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
                      controller: emailController,
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
                      controller: passwordController,
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
                        onPressed: () {
                          register(context);
                        },
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
                            padding: EdgeInsets.symmetric(
                                vertical: 18, horizontal: 40)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void register(context) async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    viewModel.register(
      emailController.text,
      passwordController.text,
      userNameController.text,
      fullNameController.text,
      context,
    );
  }
}
