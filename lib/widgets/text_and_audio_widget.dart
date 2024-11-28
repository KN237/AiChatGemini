import 'package:ai_chat/providers/chat_provider.dart';
import 'package:ai_chat/services/ai_handler.dart';
import 'package:ai_chat/services/stt_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum InputMode { mic, send, disable, unmic }

class TextAndAudioWidget extends StatefulWidget {
  const TextAndAudioWidget({super.key});

  @override
  State<TextAndAudioWidget> createState() => _TextAndAudioWidgetState();
}

class _TextAndAudioWidgetState extends State<TextAndAudioWidget> {
  final textController = TextEditingController();
  final aiHandler = AiHandler();
  final sttHander = SttHandler();
  InputMode currentMode = InputMode.mic;

  @override
  void initState() {
    sttHander.initialize();
    super.initState();
  }

  @override
  void dispose() {
    sttHander.stop();
    super.dispose();
  }

  void sendVoiceMessage() async {
    if (sttHander.speech.isListening) {
      sttHander.stop();
    } else {
      setState(() {
        currentMode = InputMode.unmic;
      });
      final result = await sttHander.startListening();

      sendTextMessage(result);
      setState(() {
        currentMode = InputMode.mic;
      });
    }
  }

  void sendTextMessage(String text) async {
    final chatProvider = context.read<ChatProvider>();
    chatProvider.addMessage(text, true);
    setState(() {
      currentMode = InputMode.disable;
    });
    await Future.delayed(const Duration(seconds: 2), () {
      chatProvider.addMessage('écris...', false, 'typing');
    });
    final aiResponse = await aiHandler.getResponse(text);
    chatProvider.removeTypingMessage();
    setState(() {
      currentMode = InputMode.mic;
    });
    chatProvider.addMessage(aiResponse, false);
  }

  void _sendRequest() async {
    final text = textController.text;
    textController.clear();
    switch (currentMode) {
      case InputMode.mic:
        sendVoiceMessage();
        break;
      case InputMode.send:
        sendTextMessage(text);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final outlinedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.4),
      ),
    );
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: textController,
                cursorColor: Theme.of(context).colorScheme.onPrimary,
                decoration: InputDecoration(
                  border: outlinedBorder,
                  enabledBorder: outlinedBorder,
                  focusedBorder: outlinedBorder,
                ),
                onChanged: (value) {
                  if (value.trim().isNotEmpty) {
                    setState(() {
                      currentMode = InputMode.send;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: currentMode == InputMode.disable ? null : _sendRequest,
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(18),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Theme.of(context).colorScheme.onSecondary),
              child: Icon(
                currentMode == InputMode.mic
                    ? Icons.mic
                    : currentMode == InputMode.unmic
                        ? Icons.mic_off
                        : Icons.send,
                size: 23,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
