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
}
