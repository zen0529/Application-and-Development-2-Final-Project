import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';
import 'sentiment.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/users/';

  // Future<bool> loginUser(String username, String password) async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/users/login/'),
  //     body: {
  //       'username': username,
  //       'password': password,
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     // Check the response from your backend to see if login is successful
  //     final data = jsonDecode(response.body);
  //     return data['success']; // Adjust this according to your API response
  //   } else {
  //     return false;
  //   }
  // }

  // Future<bool> loginUser(String username, String password) async {
  //   final response = await http.post(
  //     Uri.parse('${baseUrl}login/'),
  //     body: {
  //       'username': username,
  //       'password': password,
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     // Check the response from your backend to see if login is successful
  //     final data = jsonDecode(response.body);
  //     return data['success']; // Adjust this according to your API response
  //   } else if (response.statusCode == 404) {
  //     // User not found
  //     return false;
  //   } else {
  //     // Other errors
  //     return false;
  //   }
  // }

  Future<void> registerUser(User user) async {
    final response = await http.post(
      Uri.parse('${baseUrl}register/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to register user');
    }
  }

  Future<User> fetchUser(String username) async {
    final response = await http.get(Uri.parse('$baseUrl$username/'));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<void> updateUser(User user) async {
    final response = await http.put(
      Uri.parse('$baseUrl${user.username}/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer YOUR_AUTH_TOKEN', // Include auth token if needed
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser(String username) async {
    final response = await http.delete(Uri.parse('$baseUrl$username/'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete user');
    }
  }

  Future<List<SentimentAnalysis>> fetchSentimentAnalysis(
      String username) async {
    final response =
        await http.get(Uri.parse('$baseUrl$username/sentimentanalysis/'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => SentimentAnalysis.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load sentiment analysis');
    }
  }

  Future<void> createSentimentAnalysis(
      String username, SentimentAnalysis analysis) async {
    final url = '$baseUrl$username/sentimentanalysis/';
    print('Sending POST request to: $url'); // Debugging print

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(analysis.toJson()),
    );

    print('Response status: ${response.statusCode}'); // Debugging print
    print('Response body: ${response.body}'); // Debugging print

    if (response.statusCode != 201) {
      throw Exception('Failed to create sentiment analysis');
    }
  }
}
