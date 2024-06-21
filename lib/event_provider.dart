//Manages the state of the events list, including adding and removing events
//Setting up state management with provider
// Manages the state of the events list, including adding and removing events
// Setting up state management with provider
import 'package:flutter/material.dart';
import 'event.dart';
import 'event_service.dart';

class EventProvider with ChangeNotifier {
  List<Event> _events = [];

  List<Event> get events => _events;

  Future<void> fetchEvents() async {
    final fetchedEvents = await EventService.fetchEvents();
    _events = fetchedEvents;
    notifyListeners();
  }

  Future<void> addEvent(Event event) async {
    await EventService.addEvent(event);
    await fetchEvents();
  }

  void removeEvent(Event event) {
    _events.remove(event);
    notifyListeners();
  }
   Future<void> signup({
    required String username,
    required String email,
    required String password,
  }) async {
    // Perform signup logic, e.g., calling an authentication service
    // For demonstration purposes, we assume successful signup and authentication
    // You may want to handle errors and success responses accordingly
    // Notify listeners or update state as needed after signup
    notifyListeners();
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    // Perform login logic, e.g., calling an authentication service
    // For demonstration purposes, we assume successful login and authentication
    // You may want to handle errors and success responses accordingly
    // Notify listeners or update state as needed after login
    notifyListeners();
  }

  Future<String> _performSignup(String username, String email, String password) async {
    // Simulate signup process, returning a user ID
    // In a real application, this would interact with an authentication service
    await Future.delayed(Duration(seconds: 2)); // Simulating network delay
    return 'unique_user_id'; // Replace with actual user ID from authentication service
  }

  Future<String> _performLogin(String email, String password) async {
    // Simulate login process, returning a user ID
    // In a real application, this would interact with an authentication service
    await Future.delayed(Duration(seconds: 1)); // Simulating network delay
    return 'unique_user_id'; // Replace with actual user ID from authentication service
  }


}
