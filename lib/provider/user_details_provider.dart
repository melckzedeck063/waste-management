import 'package:flutter/material.dart';
import 'package:manage_waste/pages/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentUserProvider extends ChangeNotifier {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  final String _token = '';
  final String _userRole = '';
  final String _username = '';
  final String _firstName = '';
  final String _lastName = '';
  final String _phone = "";
  final String _notificationToken = "";

  String get token => _token;
  String get userRole => _userRole;
  String get username => _username;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get phone => _phone;
  String get notificationToken => _notificationToken;

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await _pref;
    await prefs.setString('token', token);
  }

  Future<void> saveUserRole(String role) async {
    SharedPreferences prefs = await _pref;
    await prefs.setString('role', role);
  }

  Future<void> savePhone(String phone) async {
    SharedPreferences prefs = await _pref;
    await prefs.setString('phone', phone);
  }

  Future<void> saveUsername(String username) async {
    SharedPreferences prefs = await _pref;
    await prefs.setString('username', username);
  }

  Future<void> saveFirstname(String firstName) async {
    SharedPreferences prefs = await _pref;
    await prefs.setString('firstname', firstName);
  }

  Future<void> saveLastname(String lastName) async {
    SharedPreferences prefs = await _pref;
    await prefs.setString('lastname', lastName);
  }

  Future<void> saveNotificationToken(String notificationToken) async {
    SharedPreferences prefs = await _pref;
    await prefs.setString('notificationToken', notificationToken);
    print("SAVED TOKEN TO PREF : ${notificationToken}" );
  }

  Future<String> getNotificationToken() async {
    SharedPreferences prefs = await _pref;
    return prefs.getString('notificationToken') ?? '';
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await _pref;
    return prefs.getString('token') ?? '';
  }

  Future<String> getUserRole() async {
    SharedPreferences prefs = await _pref;
    return prefs.getString('role') ?? '';
  }

  Future<String> getPhone() async {
    SharedPreferences prefs = await _pref;
    return prefs.getString('phone') ?? '';
  }

  Future<String> getUsername() async {
    SharedPreferences prefs = await _pref;
    return prefs.getString('username') ?? '';
  }

  Future<String> getFirstName() async {
    SharedPreferences prefs = await _pref;
    return prefs.getString('firstname') ?? '';
  }

  Future<String> getLastName() async {
    SharedPreferences prefs = await _pref;
    return prefs.getString('lastname') ?? '';
  }

  Future<String> getCurrentUserFirstName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('firstname') ?? '';
  }

  void logoutUser(BuildContext context) async {
    final value = await _pref;

    value.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false,  // This predicate removes all the previous routes.
    );
  }


}
