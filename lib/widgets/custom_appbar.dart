import 'package:ai_chat/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

AppBar customAppBar(String title) {
  return AppBar(
    title: Text(title),
    actions: [
      Consumer<ChatProvider>(builder: (context, chat, child) {
        return Row(
          children: [
            chat.themes == Themes.dark
                ? const Icon(Icons.dark_mode)
                : const Icon(Icons.light_mode),
            const SizedBox(
              width: 10,
            ),
            Switch.adaptive(
                value: chat.themes == Themes.dark ? true : false,
                onChanged: chat.toggleTheme),
            const SizedBox(
              width: 10,
            ),
          ],
        );
      })
    ],
  );
}
