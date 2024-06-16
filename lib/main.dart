//Import the necessary packages to be used
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'event_provider.dart';//Custom provider for managing event data
import 'event.dart';//Event model class
import 'package:table_calendar/table_calendar.dart';//Calendar package

void main() {
  //Initialize the app with EventProvider using ChangeNotifierProvider for state management
  runApp(
    ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: MyApp(),
    ),
  );
}

//Main application widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Planner',//App title
      theme: ThemeData(
        primarySwatch: Colors.blue,//Set the theme colour
      ),
      home: HomePage(),//Set the homepage as the initial screen
    );
  }
}

//Home page widget
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Casa Page'),//title in the AppBar
        centerTitle: true,//Center the tile
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to your favourite Event Planner',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Gain the allmighty power to plan your events efficiently and effectively.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  //Navigate to EventPlannerScreen when the button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EventPlannerScreen()),
                  );
                },
                child: Text('Get Started'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Event planning screen widget
class EventPlannerScreen extends StatefulWidget {
  @override
  _EventPlannerScreenState createState() => _EventPlannerScreenState();
}

//State class for EventPlannerScreen
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
        //Calendar widget to display and select dates
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
            //Consumer widget to access EventProvider and rebuild UI when events are updated
            child: Consumer<EventProvider>(
              builder: (context, eventProvider, child) {
                //Get events for the selected day
                final eventsForSelectedDay = eventProvider.events
                    .where((event) => isSameDay(event.date, _selectedDay))
                    .toList();
                return ListView.builder(
                  itemCount: eventsForSelectedDay.length,//Number of events
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(eventsForSelectedDay[index].title),//Display event title
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
        onPressed: () => _addEventDialog(context),//Show dialog to add new event
      ),
    );
  }

  void _addEventDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Event'),
        content: TextField(
          controller: _eventController,//Controller for event title input
          decoration: InputDecoration(hintText: 'Event Title'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _eventController.clear();//Clear input field
              Navigator.pop(context);//Close dialog
            },
            child: Text('Cancel'),//Cancel button
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

//model class to represent an Event
class Event {
  final String title;//Title of the event
  final DateTime date;//Date of the event

//Constructor to initialize an Event with required titleand date
  Event({required this.title, required this.date});
}

//EventProvider class to manage event data and notify listeners of changes
class EventProvider extends ChangeNotifier {
  //Private list to store events
  List<Event> _events = [];

//Getter to access the list of events
  List<Event> get events => _events;

//Method to add a new event to the list and notify listeners
  void addEvent(Event event) {
    _events.add(event);//Add event to the list
    notifyListeners();//Notify listeners to rebuild UI
  }
}

