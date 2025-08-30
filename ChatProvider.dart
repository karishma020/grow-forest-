import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatProvider extends ChangeNotifier {
  List<Map<String, String>> messages = [];

  final String apiKey = 'YOUR_OPENAI_API_KEY'; // Replace this

  void sendMessage(String userMessage) async {
    messages.add({'role': 'user', 'content': userMessage});
    notifyListeners();

    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    final body = jsonEncode({
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "system", "content": "You are a helpful eco-assistant for a carbon tracking app."},
        ...messages.map((msg) => {
              "role": msg['role'],
              "content": msg['content'],
            }),
      ],
      "max_tokens": 100,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String reply = data['choices'][0]['message']['content'].trim();
      messages.add({'role': 'assistant', 'content': reply});
      notifyListeners();
    } else {
      messages.add({'role': 'assistant', 'content': 'Error: Unable to get response'});
      notifyListeners();
    }
  }
}
