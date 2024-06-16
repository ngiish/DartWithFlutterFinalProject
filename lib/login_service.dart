import 'package:flutter/foundation.dart';
import 'api_service.dart';

class LoginService with ChangeNotifier {
  bool _isLoading = false; // Initial loading state
  bool _isAuthenticated = false; // Initial authentication state

  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;

  final ApiService _apiService = ApiService();


  // Simulate login process for demonstration
  Future<bool> login(String email, String password) async {
    // Simulate loading
    _isLoading = true;
    notifyListeners();

    bool isAuthenticated = await _apiService.login(email, password);

    _isLoading = false;
    _isAuthenticated = isAuthenticated;
    notifyListeners();

    return isAuthenticated;
  }

  // Simulate signup process for demonstration
  Future<bool> signup(String email, String password) async {
    // Simulate signup
    _isLoading = true;
    notifyListeners();

    // Simulate registration process
    await Future.delayed(Duration(seconds: 2)); 

    //Assume registration is successful if email and password are not empty
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
