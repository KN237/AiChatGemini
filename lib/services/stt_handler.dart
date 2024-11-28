import 'dart:async';

import 'package:speech_to_text/speech_to_text.dart';

class SttHandler {
  SpeechToText speech = SpeechToText();
  bool available = false;

  void initialize() async {
    available = await speech.initialize();
  }

  Future<String> startListening() async {
    final temp = Completer<String>();

    if (available) {
      await speech.listen(onResult: (result) {
        if (result.finalResult) {
          // print('result ${result.recognizedWords}');
          temp.complete(result.recognizedWords);
        }
      });
    } else {
      temp.complete('The user has denied the use of speech recognition.');
      //temp = 'The user has denied the use of speech recognition.';
    }
    final temp2 = await temp.future;

    return temp2;
  }

  void stop() async {
    await speech.stop();
  }
}
