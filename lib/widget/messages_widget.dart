import 'package:flutter/material.dart';
import 'package:med_consultation/api/firebase_api.dart';
import 'package:med_consultation/models/message.dart';

import '../data.dart';
import 'message_widget.dart';

class MessagesWidget extends StatelessWidget {
  final String idUser;

  const MessagesWidget({
    @required this.idUser,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
      stream: FirebaseApi.getMessages(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return buildText('Something Went Wrong Try later');
            } else {
              final messages = snapshot.data;

              return ListView.builder(
                physics: BouncingScrollPhysics(),
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  print(message.createdAt);

                  return (message.senderEmail ==
                                  Chat.sharedPreferences
                                      .getString(Chat.myName) &&
                              message.receiverEmail == idUser) ||
                          (message.receiverEmail ==
                                  Chat.sharedPreferences
                                      .getString(Chat.myName) &&
                              message.senderEmail == idUser)
                      ? MessageWidget(
                          message: message,
                          isMe: message.senderEmail ==
                              Chat.sharedPreferences.getString(Chat.myName),
                        )
                      : SizedBox();
                },
              );
            }
        }
      },
    );
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );
}
