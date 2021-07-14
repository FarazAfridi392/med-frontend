import 'package:flutter/material.dart';
import 'package:med_consultation/models/user.dart';
import 'package:med_consultation/screens/login_screen.dart';
import 'package:med_consultation/services/auth_service.dart';
import 'package:toast/toast.dart';
import 'package:localstorage/localstorage.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({Key key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  AuthService authService = new AuthService();


  String _radioValue = "0";

  void _handleRadioValueChange(String value) {
    setState(() {
      _radioValue = value;
    });
  }
  bool isEmail(String em) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
  void validateAndCreateAccount(){
    if(passwordController.text != confirmPasswordController.text){
      Toast.show("Password not matching", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      return;
    }
    if(passwordController.text.length <6){
      Toast.show("Password should be minimum 6 letters long", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      return;
    }
    if(!isEmail(emailController.text)){
      Toast.show("Email not valid", context,duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      return;
    }

    authService.signup(new User(email: emailController.text,password: passwordController.text,role:_radioValue)).then((response) {
    if(response.statusCode!=200){
        Toast.show("Some error occured", context,duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
        return;
    }else{
      Toast.show("Account created successfully", context,duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => LoginScreen()));
    }
    }).onError((error, stackTrace){
      print(error);
      Toast.show("Some error occured.. please check your internet connection", context,duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
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
                      'Sign up as',
                      style: TextStyle(fontSize: 20),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Radio(
                      value: "0",
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    new Text(
                      'Patient',
                      style: new TextStyle(fontSize: 16.0),
                    ),
                    new Radio(
                      value: "1",
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    new Text(
                      'Doctor',
                      style: new TextStyle(fontSize: 16.0),
                    ),
                    new Radio(
                      value: "2",
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    new Text(
                      'Admin',
                      style: new TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
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
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    obscureText: true,
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
                    ),
                  ),
                ),

                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Create Account'),
                      onPressed: () {
                        validateAndCreateAccount();
                      },
                    )),
                Container(
                    child: Row(
                      children: <Widget>[
                        Text('Already have an account?'),
                        TextButton(
                          child: Text(
                            'Sign in',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            //signup screen
                            Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
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
