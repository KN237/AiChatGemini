import 'package:ai_chat/constants/theme.dart';
import 'package:ai_chat/providers/chat_provider.dart';
import 'package:ai_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const title = 'FlutterGPT';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => ChatProvider(),
        builder: (context, child) {
          final chat = context.watch<ChatProvider>();
          return MaterialApp(
            title: title,
            debugShowCheckedModeBanner: false,
            theme: customLightTheme,
            darkTheme: customDarkTheme,
            themeMode:
                chat.themes == Themes.dark ? ThemeMode.dark : ThemeMode.light,
            home: const ChatScreen(),
          );
        }),
  );
}
