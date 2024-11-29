import 'package:google_gemini/google_gemini.dart';

class AiHandler {
  final gemini = GoogleGemini(
    apiKey: "AIzaSyBsiwDgLmEjvqj7rEQOGPb4E8xmSV8JclE",
  );

  Future<String> getResponse(String message) async {
    try {
      final response = await gemini.generateFromText(message);
      if (response.text.isNotEmpty) {
        return response.text.trim();
      }
      return 'Someting went wrong';
    } catch (e) {
      return 'Someting went wrong, please try again later !';
    }
  }
}
