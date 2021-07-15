import 'package:flutter/material.dart';

import '../utils.dart';

class MessageField {
  static final String createdAt = 'createdAt';
}

class Message {
  final String senderEmail;
  final String receiverEmail;
  final String message;
  final DateTime createdAt;

  const Message({
    @required this.senderEmail,
    @required this.receiverEmail,
    this.message,
    this.createdAt,
  });

  static Message fromJson(Map<dynamic, dynamic> json) => Message(
        senderEmail: json['senderEmail'],
        receiverEmail: json['receiverEmail'],
        message: json['message'],
        createdAt: Utils.toDateTime(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'senderEmail': senderEmail,
        'receiverEmail': receiverEmail,
        'message': message,
        'createdAt': Utils.fromDateTimeToJson(createdAt),
      };
}
