import 'package:flutter/material.dart';
import 'package:med_consultation/data.dart';
import 'package:med_consultation/models/user.dart';
import 'package:med_consultation/widget/messages_widget.dart';
import 'package:med_consultation/widget/new_message_widget.dart';
import 'package:med_consultation/widget/profile_header_widget.dart';

class ChatPage extends StatefulWidget {
  final User user;

  const ChatPage({
    @required this.user,
    Key key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: Column(
            children: [
              ProfileHeaderWidget(name: widget.user.email),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: MessagesWidget(idUser: widget.user.email),
                ),
              ),
              NewMessageWidget(idUser: widget.user.email)
            ],
          ),
        ),
      );
}
