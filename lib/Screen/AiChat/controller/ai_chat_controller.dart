// // import 'dart:convert';
// //
// // import 'package:get/get.dart';
// // import 'package:http/http.dart' as http;
// //
// // class AIChatController extends GetxController {
// //   var messages = <Map<String, String>>[].obs;
// //
// //   //final apiKey = 'AIzaSyA_b8JCgmT0_udKMRjqvusAKYu7J1B0OfA';
// //   final apiKey =
// //       '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';
// //   void sendMessage(String message) async {
// //     messages.add({'role': 'user', 'content': message});
// //     update();
// //
// //     final response = await getGeminiResponse(message);
// //     messages.add({'role': 'ai', 'content': response});
// //     update();
// //   }
// //
// //   Future<String> getGeminiResponse(String prompt) async {
// //     // const model = 'models/gemini-1.5-pro';
// //     const model = 'openai/gpt-4o';
// //     final url = Uri.parse(
// //         'https://generativelanguage.googleapis.com/v1beta/$model:generateContent?key=$apiKey');
// //     try {
// //       final response = await http.post(
// //         url,
// //         headers: {'Content-Type': 'application/json'},
// //         body: jsonEncode({
// //           'contents': [
// //             {
// //               'parts': [
// //                 {'text': prompt}
// //               ]
// //             }
// //           ]
// //         }),
// //       );
// //
// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         final reply =
// //             data['candidates'][0]['content']['parts'][0]['text'] as String;
// //         return reply.trim();
// //       } else {
// //         print("Gemini Error: ${response.body}");
// //         return "Something went wrong!";
// //       }
// //     } catch (e) {
// //       print("Exception: $e");
// //       return "Something went wrong!";
// //     }
// //   }
// // }
// import 'dart:convert';
//
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
//
// class AIChatController extends GetxController {
//   var messages = <Map<String, String>>[].obs;
//
//   // final apiKey =
//   //     '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'; // 👈 Replace this
//   final apiKey =
//       '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';
//   void sendMessage(String message) async {
//     messages.add({'role': 'user', 'content': message});
//     update();
//
//     final response = await getOpenRouterResponse(message);
//     messages.add({'role': 'ai', 'content': response});
//     update();
//   }
//
//   Future<String> getOpenRouterResponse(String prompt) async {
//     final url = Uri.parse('https://openrouter.ai/api/v1/chat/completions');
//
//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $apiKey',
//         },
//         body: jsonEncode({
//           "model": "openai/gpt-4o",
//           "messages": [
//             {
//               "role": "user",
//               "content": prompt,
//             }
//           ],
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//
//         // ✅ Add safe check
//         if (data['choices'] != null &&
//             data['choices'].isNotEmpty &&
//             data['choices'][0]['message'] != null) {
//           final reply = data['choices'][0]['message']['content'];
//           return reply.toString().trim();
//         } else {
//           print("Invalid response format: $data");
//           return "Sorry, I couldn't understand the response.";
//         }
//       } else {
//         print('OpenRouter Error: ${response.statusCode} - ${response.body}');
//         return 'Something went wrong with the API call.';
//       }
//     } catch (e) {
//       print('Exception: $e');
//       return 'Something went wrong!';
//     }
//   }
//
//   // Future<String> getOpenRouterResponse(String prompt) async {
//   //   final url = Uri.parse('https://openrouter.ai/api/v1/chat/completions');
//   //
//   //   try {
//   //     final response = await http.post(
//   //       url,
//   //       headers: {
//   //         'Content-Type': 'application/json',
//   //         'Authorization': 'Bearer $apiKey',
//   //       },
//   //       body: jsonEncode({
//   //         "model": "openai/gpt-4o",
//   //         "messages": [
//   //           {
//   //             "role": "user",
//   //             "content": prompt,
//   //           }
//   //         ],
//   //       }),
//   //     );
//   //
//   //     if (response.statusCode == 200) {
//   //       final data = jsonDecode(response.body);
//   //       final reply = data['choices'][0]['message']['content'];
//   //       return reply.toString().trim();
//   //     } else {
//   //       print('OpenRouter Error: ${response.body}');
//   //       return 'Something went wrong!';
//   //     }
//   //   } catch (e) {
//   //     print('Exception: $e');
//   //     return 'Something went wrong!';
//   //   }
//   // }
// }
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AIChatController extends GetxController {
  var messages = <Map<String, String>>[].obs;

  final apiKey =
      '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'; // 🔑 Replace this

  void sendMessage(String message) async {
    messages.add({'role': 'user', 'content': message});
    update();

    final response = await getOpenRouterResponse(message);
    messages.add({'role': 'ai', 'content': response});
    update();
  }

  Future<String> getOpenRouterResponse(String prompt) async {
    final url = Uri.parse('https://openrouter.ai/api/v1/chat/completions');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "mistralai/mistral-7b-instruct", // ✅ Free model
          "messages": [
            {
              "role": "user",
              "content": prompt,
            }
          ],
          // "max_tokens": 100,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final reply = data['choices'][0]['message']['content'];
        return reply.toString().trim();
      } else {
        print('OpenRouter Error: ${response.statusCode} - ${response.body}');
        return 'Something went wrong with the API call.';
      }
    } catch (e) {
      print('Exception: $e');
      return 'Something went wrong!';
    }
  }
}
