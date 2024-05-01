import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:manage_waste/config/URLS.dart';
import 'package:http/http.dart' as http;
import 'package:manage_waste/pages/login_screen.dart';
import 'package:manage_waste/provider/user_details_provider.dart';

import '../pages/landing_screen.dart';


class AuthenticationProvider extends ChangeNotifier {
  final RequestUrl = AppUrls.AuthUrl;


  bool _isLoading = false;
  bool _requestSuccessful = false;
  String _resMessage = "";
  bool _isError = true;


  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;
  bool get requestSuccessful =>  _requestSuccessful;
  bool get isError => _isError;

  void registerUser ({
    required String firstName,
    required String lastName,
    required String username,
    required String telephone,
    required String password,
    required BuildContext context
}) async {
    _isLoading = true;
    notifyListeners();

    String url =  "$RequestUrl/register";

    final body = {
      "firstName" : firstName,
      "lastName" : lastName,
      "username" : username,
      "phoneNumber" : telephone,
      "password" : password,
      "userRole" : "CUSTOMER"
    };

    final Map<String,String> headers = {
      "Content-Type":"application/json"
    };

    print(body);
    try {
      http.Response response  = await  http.post(Uri.parse(url), headers: headers, body: json.encode(body));

      if(response.statusCode == 200 || response.statusCode == 201) {
        final respo = json.decode(response.body);

        // print(response.statusCode);
        print(response.body);

        if(respo["error"] == false){
          _requestSuccessful = true;
          _isLoading = false;
          _isError =  false;
          _resMessage = "Account created successfuly";
        }
        else {
          _requestSuccessful = false;
          _isError = true;
          _isLoading = false;
        }



      }
      else {
        final res = json.decode(response.body);
        print("response : " +res);
        _isLoading = false;
        _requestSuccessful = false;
        notifyListeners();
      }

    } on SocketException catch(e) {
      _isLoading = false;
      _resMessage = "Connection error";
      print("Socket Exception : $e");
    } on HttpException  catch(e) {
      _isLoading = false;
      _resMessage = "Http Exception: $e";
      print(_resMessage);
    } on FormatException catch(e) {
      _isLoading = false;
      _resMessage  = "Response  format error $e";
      print(_resMessage);
    } catch(e) {
      _isLoading = false;
      _requestSuccessful = false;
      _resMessage = "An unexpected error occured: $e";
      print(_resMessage);
    }

  }


  void loginUser({
    required String username,
    required String password,
    required BuildContext context,
  }) async {
    final url = "$RequestUrl/login";

    _isLoading = true;
    notifyListeners();

    try {
      Map<String, String> body = {
        "username": username,
        "password": password
      };

      final Map<String, String> headers = {
        "Content-Type": "application/json"
      };

      final response = await http.post(Uri.parse(url), headers: headers, body: json.encode(body));

      final respo = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        _requestSuccessful = true;
        _isError = false;
        if (respo["error"] == false) {
          _requestSuccessful = true;
          _isError = false;
          _isLoading = false;
          _resMessage = "Login successful";

          String token = respo["data"]["token"];
          String username = respo["data"]["username"];
          String firstname = respo["data"]["firstName"];
          String lastname = respo["data"]["lastName"];
          String userRole =  respo["data"]["userType"];

          print(respo["data"]);
          print(userRole);

          CurrentUserProvider().saveToken(token);
          CurrentUserProvider().saveUsername(username);
          CurrentUserProvider().saveFirstname(firstname + " " + lastname);
          CurrentUserProvider().saveUserRole(userRole);
          // CurrentUserProvider().saveLastname(lastname);

        } else {
          _isLoading = false;
          _requestSuccessful = false;
          _isError = true;
          _resMessage = "Login failed: ${respo['error']}";
        }
      } else {
        final res = json.decode(response.body);
        print("response : $res");
        _isLoading = false;
        _requestSuccessful = false;
        _isError = true;
        _resMessage = "Login failed: ${res['error']}";
      }
    } on SocketException catch (e) {
      _isLoading = false;
      _requestSuccessful = false;
      _isError = true;
      _resMessage = "Connection error: $e";
      print("Socket Exception : $e");
    } on HttpException catch (e) {
      _isLoading = false;
      _isError = true;
      _resMessage = "HTTP Exception: $e";
      print(_resMessage);
    } on FormatException catch (e) {
      _isLoading = false;
      _isError = true;
      _resMessage = "Response format error: $e";
      print(_resMessage);
    } catch (e) {
      _isLoading = false;
      _requestSuccessful = false;
      _isError = true;
      _resMessage = "An unexpected error occurred: $e";
      print(_resMessage);
    } finally {
      notifyListeners();
    }
  }




}