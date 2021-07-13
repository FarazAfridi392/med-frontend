import 'package:flutter/material.dart';
import 'package:med_consultation/models/login_user.dart';
import 'package:med_consultation/screens/admin/admin_home.dart';
import 'package:med_consultation/screens/doctor/doctor_home.dart';
import 'package:med_consultation/screens/patient/patient_home.dart';
import 'package:med_consultation/screens/signup_screen.dart';
import 'package:med_consultation/services/auth_service.dart';
import 'package:toast/toast.dart';
import 'dart:convert';
import 'package:localstorage/localstorage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthService authService = new AuthService();
  LocalStorage localStorage = new LocalStorage('mystore');
  int _radioValue = 0;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  void validateAndLogin() {
    if (!isEmail(emailController.text)) {
      Toast.show("Email not valid", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      return;
    }
    if (passwordController.text.length < 6) {
      Toast.show("Password should be minimum 6 letters long", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      return;
    }
    authService
        .login(new LoginUser(emailController.text, passwordController.text))
        .then((response) async {
      final body = json.decode(response.body);
      var user = body['user'];
      var details = body['details'];
      print(details);
      await localStorage.setItem('user', user);
      await localStorage.setItem('details', details);
      //TODO,NAVIGATE after login
      if (details['role'] == "0") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PatientHome()),
        );
        //TODO patient
      } else if (details['role'] == "1") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DoctorHome()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminHome()),
        );
      }
    }).onError((error, stackTrace) {
      print(error);
      Toast.show("Some error occured", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Consult Doctor'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Consult Doctor',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     new Radio(
                //       value: 0,
                //       groupValue: _radioValue,
                //       onChanged: _handleRadioValueChange,
                //     ),
                //     new Text(
                //       'Patient',
                //       style: new TextStyle(fontSize: 16.0),
                //     ),
                //     new Radio(
                //       value: 1,
                //       groupValue: _radioValue,
                //       onChanged: _handleRadioValueChange,
                //     ),
                //     new Text(
                //       'Doctor',
                //       style: new TextStyle(fontSize: 16.0),
                //     ),
                //     new Radio(
                //       value: 2,
                //       groupValue: _radioValue,
                //       onChanged: _handleRadioValueChange,
                //     ),
                //     new Text(
                //       'Admin',
                //       style: new TextStyle(fontSize: 16.0),
                //     ),
                //   ],
                // ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    //forgot password screen
                    //TODO : add forget password feature
                  },
                  child: Text('Forgot Password'),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Login'),
                      onPressed: () {
                        validateAndLogin();
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Does not have account?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Sign up',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        //signup screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen()),
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}
//TODO: email trim