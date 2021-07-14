// TODO to change current user use the required data and hot restart

// Christine
// String myId = '5oRHGIPx1Z0wJa3z3Y9S';
// String myUsername = 'Christine Wallace';
// String myUrlAvatar = 'https://i.imgur.com/GXoYikT.png';

// Napoleon
import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:med_consultation/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chat {
  static SharedPreferences sharedPreferences;
  static final String myName = 'name';
  String myUsername;
  String myUrlAvatar;
}
