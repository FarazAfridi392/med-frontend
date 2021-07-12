import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:med_consultation/models/login_user.dart';
import 'package:med_consultation/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:med_consultation/Constants.dart' as Constants;
class AuthService{
  LocalStorage localStorage = new LocalStorage('mystore');
  Future<http.Response> signup(User user) {
    var url = Uri.parse(Constants.BASE_URL+'/signup');
    return http.post(url, body: user.toJson());
  }
  Future<http.Response> login(LoginUser user) {
    var url = Uri.parse(Constants.BASE_URL+'/login');
    return http.post(url, body: user.toJson());
  }
  Future<http.Response> logout() async{
    var user = localStorage.getItem('user');

    var uid = user['uid'];
    http.post(Uri.parse(Constants.BASE_URL+'/logout'),body: {
      "uid":uid
    });
    localStorage.deleteItem("user");
    localStorage.deleteItem("details");

  }
  Future<http.Response> authenticate(){
    var user = localStorage.getItem('user');
    if(user==null){
      return null;
    }
    var idToken = user['stsTokenManager']['refreshToken'];
    print(idToken);
    return http.post(Uri.parse(Constants.BASE_URL+'/authenticate'),body: {
      "token":idToken
    });
  }
}