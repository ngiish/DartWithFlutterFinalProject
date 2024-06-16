// signup_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_service.dart'; // Import your LoginService

class SignupPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
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
                // Use the LoginService provided by Provider
                LoginService loginService = Provider.of<LoginService>(context, listen: false);
                bool isRegistered = await loginService.signup(
                  _emailController.text,
                  _passwordController.text,
                );

                if (isRegistered) {
                  // Navigate to login page or other destination after successful registration
                  Navigator.pushReplacementNamed(context, '/login');
                } else {
                  // Handle registration failure (show error message)
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Registration Failed'),
                      content: Text('Failed to register user.'),
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
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
