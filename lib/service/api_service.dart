import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<String> getServerResponse(String message) async {
    const apiUrl = 'https://2spapi.shop/euno';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({'text': message}),
    );

    if (response.statusCode == 200) {
      String responseBody = const Utf8Decoder().convert(response.bodyBytes);
      Map<String, dynamic> responseData = json.decode(responseBody);
      String serverResponse = responseData['translatedText'] ?? '응답 없음';

      return serverResponse;
    } else {
      return 'Error: Unable to get response from the server';
    }
  }
}
