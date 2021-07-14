import 'package:flutter/material.dart';
import 'package:med_consultation/utils.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class User {
  final String email;
  final String password;
  final String role;

  const User({
    this.email,
    @required this.password,
    @required this.role,
  });

  User copyWith({
    String email,
    String password,
    String role,
  }) =>
      User(
        email: email ?? this.email,
        password: password ?? this.password,
        role: role ?? this.role,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        email: json['email'],
        password: json['password'],
        role: json['role'],
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'role': role,
      };
}
