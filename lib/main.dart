
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'event_provider.dart';
import 'event.dart';
import 'package:table_calendar/table_calendar.dart';

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
      home: EventPlannerScreen(),
    );
  }
}

class EventPlannerScreen extends StatefulWidget {
  @override
  _EventPlannerScreenState createState() => _EventPlannerScreenState();
}

class _EventPlannerScreenState extends State<EventPlannerScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  final TextEditingController _eventController = TextEditingController();

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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Event'),
        content: TextField(
          controller: _eventController,
          decoration: InputDecoration(hintText: 'Event Title'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _eventController.clear();
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final eventProvider =
                  Provider.of<EventProvider>(context, listen: false);
              eventProvider.addEvent(Event(
                title: _eventController.text,
                date: _selectedDay,
              ));
              _eventController.clear();
              Navigator.pop(context);
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
