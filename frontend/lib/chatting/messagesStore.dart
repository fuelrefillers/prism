import 'dart:convert';
import 'package:frontend/chatting/models/MessagesModels.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageStore {
  late SharedPreferences _prefs;

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveMessagesForId(String id, List<MessageModel> messages) async {
    List<String> encodedMessages =
        messages.map((message) => json.encode(message.toMap())).toList();
    await _prefs.setStringList(id, encodedMessages);
  }

  List<MessageModel> getMessagesForId(String id) {
    final List<String>? encodedMessages = _prefs.getStringList(id);
    if (encodedMessages != null) {
      return encodedMessages
          .map((encodedMessage) =>
              MessageModel.fromMap(json.decode(encodedMessage)))
          .toList();
    }
    return [];
  }
}
