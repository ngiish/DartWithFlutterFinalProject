// login_service.dart

import 'package:flutter/foundation.dart';

class LoginService with ChangeNotifier {
  bool _isLoading = false; // Initial loading state
  bool _isAuthenticated = false; // Initial authentication state

  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;

  // Simulate login process for demonstration
  Future<bool> login(String email, String password) async {
    // Simulate loading
    _isLoading = true;
    notifyListeners();

    // Simulate authentication process
    await Future.delayed(Duration(seconds: 2)); // Replace with actual auth logic

    // Check credentials (replace with actual authentication logic)
    if (email == 'test@example.com' && password == 'password') {
      _isAuthenticated = true;
    } else {
      _isAuthenticated = false;
    }

    _isLoading = false; // Done loading
    notifyListeners();

    return _isAuthenticated;
  }

  // Simulate signup process for demonstration
  Future<bool> signup(String email, String password) async {
    // Simulate loading
    _isLoading = true;
    notifyListeners();

    // Simulate registration process
    await Future.delayed(Duration(seconds: 2)); // Replace with actual registration logic

    // For demo purposes, assume registration is successful if email and password are not empty
    bool registrationSuccessful = email.isNotEmpty && password.isNotEmpty;

    if (registrationSuccessful) {
      // Optionally, you could automatically login the user after successful registration
      _isAuthenticated = true;
    } else {
      _isAuthenticated = false;
    }

    _isLoading = false; // Done loading
    notifyListeners();

    return registrationSuccessful;
  }
}
