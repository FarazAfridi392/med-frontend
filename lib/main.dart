import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:med_consultation/screens/admin/admin_home.dart';
import 'package:med_consultation/screens/patient/patient_home.dart';
import 'package:med_consultation/services/auth_service.dart';
import './screens/splash_screen.dart';
import './screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  AuthService authService = new AuthService();
  LocalStorage localStorage = new LocalStorage("mystore");
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(new Duration(seconds: 3)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
              home: SplashScreen(), debugShowCheckedModeBanner: false);
        } else {
          var details = localStorage.getItem("details");
          if (details == null) {
            return MaterialApp(
                debugShowCheckedModeBanner: false, home: LoginScreen());
          }
          if (details['role'] == '2')
            return MaterialApp(
                debugShowCheckedModeBanner: false, home: AdminHome());
          if (details['role'] == '1')
            return MaterialApp(
                debugShowCheckedModeBanner: false, home: AdminHome());
          if (details['role'] == '0')
            return MaterialApp(
                debugShowCheckedModeBanner: false, home: PatientHome());
          return MaterialApp(
              debugShowCheckedModeBanner: false, home: LoginScreen());
        }
      },
    );
  }
}
