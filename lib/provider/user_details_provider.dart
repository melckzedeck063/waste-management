

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentUserProvider extends ChangeNotifier {

  final Future<SharedPreferences> _pref =  SharedPreferences.getInstance();

  String _token = "";
  String _userRole = "";
  String _username = "";
  String _firstName = "";

  String get token => _token;
  String get userRole => _userRole;
  String get username => _username;
  String get firstName => _firstName;

  void saveToken(String token) async {
    SharedPreferences value = await _pref;

    value.setString('token', token);
  }

  void saveUserRole(String role) async {
    SharedPreferences value = await _pref;

    value.setString("role", userRole);
  }

  void saveUsername(String username) async {
    SharedPreferences value = await _pref;

    value.setString("username", username);
  }

  void saveFirstname(String username) async {
    SharedPreferences value = await _pref;

    value.setString("firstname", firstName);
  }




  Future<String> getToken() async {
    SharedPreferences value =  await _pref;

    if(value.containsKey("token")){
      String data =  value.getString("token")!;
      _token =  data;
      notifyListeners();
      return data;
    }
    else {
      _token = "";
      notifyListeners();
      return "";
    }
  }

  Future<String> getUserRole() async {
    SharedPreferences value =  await _pref;

    if(value.containsKey("role")){
      String data =  value.getString("role")!;
      _userRole =  data;
      notifyListeners();
      return data;
    }
    else {
      _userRole = "";
      notifyListeners();
      return "";
    }
  }

  Future<String> getUsername() async {
    SharedPreferences value =  await _pref;

    if(value.containsKey("username")){
      String data =  value.getString("username")!;
      _username =  data;
      notifyListeners();
      return data;
    }
    else {
      _username = "";
      notifyListeners();
      return "";
    }
  }

  Future<String> getFirstName() async {
    SharedPreferences value =  await _pref;

    if(value.containsKey("firstname")) {
      String data = value.getString("firstname")!;
      _firstName = data;
      notifyListeners();
      return data;
    }
    else {
      _firstName = "";
      notifyListeners();
      return "";
    }
  }

}