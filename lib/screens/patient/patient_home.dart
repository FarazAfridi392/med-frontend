import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:med_consultation/screens/login_screen.dart';
import 'package:med_consultation/services/auth_service.dart';
import 'package:med_consultation/services/patient_service.dart';
import 'package:http/http.dart' as http;

class PatientHome extends StatefulWidget {
  const PatientHome({Key key}) : super(key: key);

  @override
  _PatientHomeState createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  PatientService patientService=new PatientService();
  AuthService authService= new AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(icon: const Icon(Icons.message), onPressed: (){

          }),
          IconButton(onPressed: (){
            authService.logout();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>LoginScreen()),
            );
          }, icon: const Icon(Icons.logout))
        ],
      ),
      body: FutureBuilder(
        future: patientService.getAllDoctors() ,
        builder: (context, snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return new CircularProgressIndicator();
          }else{
            http.Response response= snapshot.data;
            return Column(
              children: getDoctorList(response),
            );
          }

        },
      ),
    );
  }

  List<Widget> getDoctorList(http.Response response) {
    List<dynamic> body = json.decode(response.body);
    List <Widget> widgetList= [];
    if(body.isEmpty){
      widgetList.add(
        Text("No doctors available")
      );
    }else{
      body.forEach((element) {
        widgetList.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(element['email']),
            ),
          )
        );
      });
    }
    return widgetList;

  }
}
