// main.dart
//Import the necessary packages to be used

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_service.dart'; // Import your LoginService
import 'signup_page.dart'; // Import your SignupPage
import 'event_provider.dart'; // Custom provider for managing event data
import 'event.dart'; // Event model class
import 'package:table_calendar/table_calendar.dart'; // Calendar package
import 'login_page.dart'; // Import the LoginPage

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EventProvider()),
        ChangeNotifierProvider(create: (context) => LoginService()),
      ],
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
      initialRoute: '/login', // Set initial route to login page
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(hintText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Use the LoginService to authenticate
                LoginService loginService = Provider.of<LoginService>(context, listen: false);
                bool isAuthenticated = await loginService.login(
                  _emailController.text,
                  _passwordController.text,
                );

                if (isAuthenticated) {
                  // Navigate to home page if authenticated
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  // Handle authentication failure (show error message)
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Authentication Failed'),
                      content: Text('Invalid email or password.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
