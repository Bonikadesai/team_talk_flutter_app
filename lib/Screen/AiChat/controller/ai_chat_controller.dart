import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AIChatController extends GetxController {
  var messages = <Map<String, String>>[].obs;

  final apiKey = 'AIzaSyA_b8JCgmT0_udKMRjqvusAKYu7J1B0OfA';

  void sendMessage(String message) async {
    messages.add({'role': 'user', 'content': message});
    update();

    final response = await getGeminiResponse(message);
    messages.add({'role': 'ai', 'content': response});
    update();
  }

  Future<String> getGeminiResponse(String prompt) async {
    const model = 'models/gemini-1.5-pro';
    final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/$model:generateContent?key=$apiKey');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final reply =
            data['candidates'][0]['content']['parts'][0]['text'] as String;
        return reply.trim();
      } else {
        print("Gemini Error: ${response.body}");
        return "Something went wrong!";
      }
    } catch (e) {
      print("Exception: $e");
      return "Something went wrong!";
    }
  }
}
