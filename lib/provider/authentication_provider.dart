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


  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;
  bool get requestSuccessful =>  _requestSuccessful;

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
      "userRole" : "USER"
    };

    final Map<String,String> headers = {
      "Content-Type":"application/json"
    };

    print(body);
    try {
      http.Response response  = await  http.post(Uri.parse(url), headers: headers, body: json.encode(body));

      if(response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);

        _isLoading = false;
        _resMessage = "Account created successfuly";
        _requestSuccessful =  true;
        notifyListeners();

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => const LoginScreen())
        // );

      }
      else {
        final res = json.decode(response.body);
        print(res);
        _isLoading = false;
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

    _isLoading  = true;
    notifyListeners();

    Map<String,String> body  = {
      "username" : username,
      "password" : password
    };

    final Map<String, String> headers = {
      "Content-Type" : "application/json"
    };


    try {
       http.Response response  =  await http.post(Uri.parse(url), headers: headers, body: json.encode(body));

       if(response.statusCode == 200 || response.statusCode == 201){
         _isLoading = false;
         _requestSuccessful = true;
         _resMessage = "Login Successful";

         final resp = json.decode(response.body);

         print(resp);

         String token = resp["token"];
         String username = resp["username"];
         String user_role = "";
         String firstname = resp["fullName"];

         // print(token + " " + firstname);

         CurrentUserProvider().saveToken(token);
         CurrentUserProvider().saveUsername(username);
         CurrentUserProvider().saveFirstname(firstname);

       }
       else {
         final res = json.decode(response.body);
         print(res);
         _isLoading = false;
         notifyListeners();
       }

    }on SocketException catch(e) {
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
      _resMessage = "An unexpected error occured: $e";
      print(_resMessage);
    }

  }



}