import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  static const String apiKey = 'YOUR_OPENAI_API_KEY'; // ⬅ Replace this
  static const String endpoint = 'https://api.openai.com/v1/chat/completions';

  Future<String> getResponse(String message) async {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {"role": "system", "content": "You are EcoBot, a helpful environmental assistant."},
          {"role": "user", "content": message},
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to get response from OpenAI: ${response.body}');
    }
  }
}
