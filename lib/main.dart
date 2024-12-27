import 'package:chatnow/ui/home/Home_Screen.dart';
import 'package:chatnow/ui/login/Login_Screen.dart';
import 'package:chatnow/ui/register/Register_Screen.dart';
import 'package:chatnow/ui/splash/Splash_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.transparent,
              titleTextStyle: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true),
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color(0xff3598DB),
              primary: Color(0xff3598DB),
              onPrimary: Colors.white,
              secondary: Colors.white,
              onSecondary: Colors.black),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.transparent),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        HomeScreen.routeName: (_) => HomeScreen()
      },
    );
  }
}
