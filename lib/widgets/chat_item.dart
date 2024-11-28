import 'dart:math';

import 'package:ai_chat/model/chat_model.dart';
import 'package:flutter/material.dart';

final r = Random();

class ChatItem extends StatelessWidget {
  const ChatItem({super.key, required this.chatModel});
  final ChatModel chatModel;
  @override
  Widget build(BuildContext context) {
    final dim = MediaQuery.of(context).size.width * 0.5;
    return Row(
      mainAxisAlignment: chatModel.isMe == false
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (chatModel.isMe == false)
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: chatModel.isMe == false
                  ? Colors.grey.shade800
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: chatModel.isMe == false
                    ? const Radius.circular(20)
                    : Radius.zero,
                bottomRight: chatModel.isMe == true
                    ? const Radius.circular(20)
                    : Radius.zero,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.computer,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        const SizedBox(
          width: 10,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 18),
          constraints: BoxConstraints(maxWidth: dim),
          decoration: BoxDecoration(
            color: chatModel.isMe == false
                ? Colors.grey.shade800
                : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft: chatModel.isMe == false
                  ? Radius.zero
                  : const Radius.circular(20),
              bottomRight: chatModel.isMe == true
                  ? Radius.zero
                  : const Radius.circular(20),
            ),
          ),
          child: Center(
            child: Text(
              chatModel.message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        if (chatModel.isMe == true)
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: chatModel.isMe == false
                  ? Colors.grey.shade800
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: chatModel.isMe == false
                    ? const Radius.circular(20)
                    : Radius.zero,
                bottomRight: chatModel.isMe == true
                    ? const Radius.circular(20)
                    : Radius.zero,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
      ],
    );
  }
}
