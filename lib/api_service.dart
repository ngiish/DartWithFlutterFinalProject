import 'dart:convert';
import 'package:http/http.dart' as http;

// Define a class for API service interactions
class ApiService {
  // Base URL for the API
  final String _baseUrl = 'http://localhost:3000';

  // Method for user login
  Future<bool> login(String email, String password) async {
    // Make a POST request to the /login endpoint with the email and password
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      // Parse the response body to a JSON object
      final Map<String, dynamic> responseBody = json.decode(response.body);
      // Return the value of the 'authenticated' key from the JSON object
      return responseBody['authenticated'];
    } else {
      // Return false if the status code is not 200
      return false;
    }
  }

  // Method for user signup
  Future<bool> signup(String email, String password) async {
    // Make a POST request to the /signup endpoint with the email and password
    final response = await http.post(
      Uri.parse('$_baseUrl/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      // Return true if signup was successful
      return true;
    } else {
      // Return false if the status code is not 200
      return false;
    }
  }
}
