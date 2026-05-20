import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/Services_api/signup_Api.dart';

class UserProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _isLoggedIn = false;
  String? _userEmail;
  Map<String, dynamic>? _userData;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  bool isFirstTime = false;
  String? get userEmail => _userEmail;
  Map<String, dynamic>? get userData => _userData;

  // ✅ Constructor - Check login status on app start
  UserProvider() {
    _checkLoginStatus();
  }

  // ✅ Check if user is already logged in
  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _userEmail = prefs.getString('userEmail');
    print("Login Status: $_isLoggedIn, Email: $_userEmail");
    notifyListeners();
  }

  // ✅ LOGIN
  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      var response = await UserService.loginUser(
        email: email,
        password: password,
      );

      print("Login Response: $response");

      if (response['status'] == true) {
        // ✅ Save to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userEmail', email);
        // Optional: Save full user data as JSON
        // await prefs.setString('userData', jsonEncode(response));

        _isLoggedIn = true;
        _userEmail = email;
        _userData = response;

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("Login Error: $e");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // ✅ LOGOUT
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('userEmail');
    await prefs.remove('userData');

    _isLoggedIn = false;
    _userEmail = null;
    _userData = null;
    notifyListeners();
  }

  // ✅ SIGNUP
  Future<bool> registerUser({
    required String name,
    required String number,
    required String email,
    required String address,
    required String password,
    required String profile_image,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      var response = await UserService.registerUser(
        name: name,
        number: number,
        email: email,
        address: address,
        password: password,
        profile_Image: profile_image,
      );

      print("Signup Response: $response");

      _isLoading = false;
      notifyListeners();

      return response['status'] == true;
    } catch (e) {
      print("Signup Error: $e");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}