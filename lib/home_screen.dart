// home_screen.dart
import 'package:flutter/material.dart';
import 'event_planner_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Event Planner'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventPlannerScreen()),
                );
              },
            ),
            // Add more navigation buttons or widgets here as needed
          ],
        ),
      ),
    );
  }
}

