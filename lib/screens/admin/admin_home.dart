import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:med_consultation/screens/login_screen.dart';
import 'package:med_consultation/services/admin_service.dart';
import 'package:med_consultation/services/auth_service.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  AdminService adminService = new AdminService();
  AuthService authService = new AuthService();
  List<dynamic> requestList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consult Doctor | Admin'),
        actions: [
          IconButton(
              onPressed: () {
                authService.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: FutureBuilder(
          future: adminService.getAllAccountRequests(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              Response response = snapshot.data;
              return new Column(
                children: <Widget>[
                  new Expanded(child: new ListView(children: _getRow(response)))
                ],
              );
            } else {
              return Center(child: new CircularProgressIndicator());
            }
          }),
    );
  }

  List<Widget> _getRow(Response response) {
    List<dynamic> body = json.decode(response.body);
    print(response.body);
    List<Widget> widgetList = [];
    if (body.isEmpty) {
      widgetList.add(Center(
          child: Text(
        "No request available",
        style: TextStyle(fontWeight: FontWeight.bold),
      )));
      return widgetList;
    }
    body.forEach((element) {
      widgetList.add(Container(
        padding: EdgeInsets.only(top: 8),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            child: Text(
              element['email'][0].toUpperCase(),
            ),
          ),
          title: Text(
            element['email'],
            overflow: TextOverflow.ellipsis,
          ),
          trailing: MaterialButton(
              child: Container(
                height: 20,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue),
                child: Center(child: Text('Accept')),
              ),
              onPressed: () {
                adminService
                    .acceptAccountRequest(element['uid'])
                    .then((value) => setState(() {}));
              }),
        ),
      ));
    });
    return widgetList;
  }
}
