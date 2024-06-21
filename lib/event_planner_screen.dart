import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class EventPlannerScreen extends StatefulWidget {
  @override
  _EventPlannerScreenState createState() => _EventPlannerScreenState();
}

class _EventPlannerScreenState extends State<EventPlannerScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  final TextEditingController _eventController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<EventProvider>(context, listen: false).fetchEvents();
  }

  @override
  void dispose() {
    _eventController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Planner'),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: Consumer<EventProvider>(
              builder: (context, eventProvider, child) {
                final eventsForSelectedDay = eventProvider.events
                    .where((event) => isSameDay(event.date, _selectedDay))
                    .toList();
                return ListView.builder(
                  itemCount: eventsForSelectedDay.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(eventsForSelectedDay[index].title),
                      subtitle: Text(eventsForSelectedDay[index].description),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addEventDialog(context),
      ),
    );
  }

  void _addEventDialog(BuildContext context) {
     final TextEditingController _eventController = TextEditingController();
     final TextEditingController _descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Event'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _eventController,
              decoration: InputDecoration(hintText: 'Event Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(hintText: 'Event Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _eventController.clear();
              _descriptionController.clear();
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_eventController.text.isEmpty || _descriptionController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Title and Description cannot be empty'),
                ));
                return;
              }
              final eventProvider =
                  Provider.of<EventProvider>(context, listen: false);
              eventProvider.addEvent(Event(
                id: 'unique_id', // Provide a unique ID here
                createdBy: 'current_user', // Provide the current user ID here
                title: _eventController.text,
                description: _descriptionController.text,
                date: _selectedDay,
              ));
              _eventController.clear();
              _descriptionController.clear();
              Navigator.pop(context);
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}

class Event {
  final String id;
  final String createdBy;
  final String title;
  final String description;
  final DateTime date;

  Event({
    required this.id,
    required this.createdBy,
    required this.title,
    required this.description,
    required this.date,
  });
}

class EventProvider extends ChangeNotifier {
  List<Event> _events = [];

  List<Event> get events => _events;

  void addEvent(Event event) {
    _events.add(event);
    notifyListeners();
  }

  Future<void> fetchEvents() async {
    // Fetch events from the database or API and assign to _events
    // For demonstration, we'll use an empty list
    _events = [];
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Planner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EventPlannerScreen(), // Set EventPlannerScreen as the initial screen
    );
  }
}
