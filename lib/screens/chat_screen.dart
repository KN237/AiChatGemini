import 'package:ai_chat/providers/chat_provider.dart';
import 'package:ai_chat/widgets/chat_item.dart';
import 'package:ai_chat/widgets/custom_appbar.dart';
import 'package:ai_chat/widgets/text_and_audio_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const title = 'FlutterGPT';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();
    return Scaffold(
      appBar: customAppBar(title),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: chatProvider.chat.isNotEmpty
                ? ListView.builder(
                    itemCount: chatProvider.chat.length,
                    padding: const EdgeInsets.only(bottom: 15),
                    reverse: true,
                    itemBuilder: (ctx, index) {
                      final newList = chatProvider.chat.reversed.toList();
                      return ChatItem(chatModel: newList[index]);
                    },
                  )
                : const Center(
                    child: Text('No Message Yet !'),
                  ),
          ),
          const TextAndAudioWidget(),
        ],
      ),
    );
  }
}
