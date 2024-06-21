//The code here helps create a service to handle API calls
//Creation of a service to fetch data
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'event.dart';

class EventService {
  static const String url = 'http://localhost:3000/events';

  static Future<List<Event>> fetchEvents() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((event) => Event.fromJson(event)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }

  static Future<void> addEvent(Event event) async {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(event.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add event');
    }
  }
}
