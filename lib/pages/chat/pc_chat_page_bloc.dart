import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'pc_chat_page_model.dart';

class ChatBloc {
  final StreamController<List<ChatMessage>> _messagesController =
      StreamController<List<ChatMessage>>.broadcast();

  List<ChatMessage> initMessage = [];

  Stream<List<ChatMessage>> get messages => _messagesController.stream;

  void loadMessages(String friendName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? messages = prefs.getStringList(friendName);
    if (messages != null) {
      initMessage = messages
          .map((m) => ChatMessage(message: m, sender: friendName))
          .toList();
      _messagesController.sink.add(initMessage);
    }
  }

  void addMessage(String text, String friendName) {
    if (text.isNotEmpty) {
      initMessage.add(ChatMessage(message: text, sender: 'Me'));
      _saveMessages(friendName);
      _messagesController.sink.add(initMessage);
    }
  }

  void deleteMessage(int index, String friendName) {
    initMessage.removeAt(index);
    _saveMessages(friendName);
    _messagesController.sink.add(initMessage);
  }

  void dispose() {
    _messagesController.close();
  }

  void _saveMessages(String friendName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> messages = initMessage.map((m) => m.message).toList();
    prefs.setStringList(friendName, messages);
  }
}
