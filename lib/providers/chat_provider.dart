import 'package:ai_chat/model/chat_model.dart';
import 'package:flutter/material.dart';

enum Themes { light, dark }

class ChatProvider extends ChangeNotifier {
  final List<ChatModel> chat = [];
  Themes themes = Themes.dark;

  void toggleTheme(bool value) {
    if (value == true) {
      themes = Themes.dark;
    } else {
      themes = Themes.light;
    }
    notifyListeners();
  }

  void addMessage(String message, bool isMe, [String? id]) {
    if (message.trim().isNotEmpty) {
      chat.add(
        ChatModel(
            id: id ?? DateTime.now().millisecondsSinceEpoch.toString(),
            message: message,
            isMe: isMe),
      );
    } else {
      throw 'Message is empty !';
    }
    notifyListeners();
  }

  void removeTypingMessage() {
    chat.remove(chat.firstWhere((elt) => elt.id == 'typing'));
    notifyListeners();
  }
}
