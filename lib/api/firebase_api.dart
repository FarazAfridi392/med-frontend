import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:med_consultation/data.dart';
import 'package:med_consultation/models/message.dart';
import 'package:med_consultation/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils.dart';

class FirebaseApi {
  static Stream<List<User>> getUsers() => FirebaseFirestore.instance
      .collection('users')
      .orderBy(UserField.lastMessageTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(User.fromJson));

  static Future uploadMessage(String email, String message) async {
    final refMessages =
        FirebaseFirestore.instance.collection('chats/$email/messages');

    final newMessage = Message(
      email: Chat.sharedPreferences.getString(Chat.myName),
      urlAvatar: Chat.sharedPreferences.getString(Chat.myName[0].toUpperCase()),
      username: 'faraz',
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());

    final refUsers = FirebaseFirestore.instance.collection('users');
    await refUsers
        .doc(email)
        .update({UserField.lastMessageTime: DateTime.now()});
  }

  static Stream<List<Message>> getMessages(String email) =>
      FirebaseFirestore.instance
          .collection('chats/$email/messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));

  static Future addRandomUsers(List<User> users) async {
    final refUsers = FirebaseFirestore.instance.collection('users');

    final allUsers = await refUsers.get();
    if (allUsers.size != 0) {
      return;
    } else {
      for (final user in users) {
        final userDoc = refUsers.doc();
        final newUser = user.copyWith(email: userDoc.id);

        await userDoc.set(newUser.toJson());
      }
    }
  }
}
