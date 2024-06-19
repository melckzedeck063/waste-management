import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:manage_waste/config/URLS.dart';
import 'package:http/http.dart' as http;
import 'package:manage_waste/models/user_model.dart';
import 'package:manage_waste/pages/login_screen.dart';
import 'package:manage_waste/provider/user_details_provider.dart';

import '../pages/landing_screen.dart';


class AuthenticationProvider extends ChangeNotifier {
  final RequestUrl = AppUrls.AuthUrl;


  bool _isLoading = true;
  bool _requestSuccessful = false;
  String _resMessage = "";
  bool _isError = true;


  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;
  bool get requestSuccessful =>  _requestSuccessful;
  bool get isError => _isError;

   registerUser ({
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

        if(respo["error"] == false){
          _requestSuccessful = true;
          _isLoading = false;
          _isError =  false;
          _resMessage = "Account created successfuly";

          Future.delayed( Duration(seconds: 3), (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen())
            );
          });
        }
        else {
          _requestSuccessful = false;
          _resMessage = respo['message'];
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


   loginUser({
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
      // print(respo);
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
          String phone = respo["data"]["phone"];

          CurrentUserProvider().saveToken(token);
          CurrentUserProvider().saveUsername(username);
          CurrentUserProvider().saveFirstname(firstname + " " + lastname);
          CurrentUserProvider().saveUserRole(userRole);
          CurrentUserProvider().savePhone(phone);

          Future.delayed( Duration(seconds: 6), (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LandingScreen())
            );
          });

        } else {
          _isLoading = false;
          _requestSuccessful = false;
          _isError = true;
          _resMessage = "Login failed: ${respo['message']}";
        }
      } else {
        final res = json.decode(response.body);
        print("response : $res");
        _isLoading = false;
        _requestSuccessful = false;
        _isError = true;
        _resMessage = "Login failed: ${res['message']}";
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


  void changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    final url = "$RequestUrl/update-password";

    _isLoading = true;
    notifyListeners();

    try {
      Map<String, String> body = {
        "currentPassword": currentPassword,
        "newPassword": newPassword,
        "confirmPassword" : confirmPassword
      };


      final token = await CurrentUserProvider().getToken();

      final Map<String,String> headers = {
        "Content-Type":"application/json",
        "Authorization" : "Bearer $token"
      };

      final response = await http.put(Uri.parse(url), headers: headers, body: json.encode(body));

      final respo = json.decode(response.body);
      print(respo);
      print(body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _requestSuccessful = true;
        _isError = false;
        if (respo["error"] == false) {
          _requestSuccessful = true;
          _isError = false;
          _isLoading = false;
          _resMessage = respo['message'];

          // Future.delayed( Duration(seconds: 5), (){
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const LandingScreen())
          //   );
          // });

        } else {
          _isLoading = false;
          _requestSuccessful = false;
          _isError = true;
          _resMessage = respo['message'];
        }
      } else {
        final res = json.decode(response.body);
        print("response : $res");
        _isLoading = false;
        _requestSuccessful = false;
        _isError = true;
        _resMessage = res['message'];
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

  Future<UserModel> getMyProfile() async {
    _isLoading = true;
    notifyListeners();

    String url =  "$RequestUrl/me";

    final token =  await CurrentUserProvider().getToken();


    final Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization" : "Bearer $token"
      // Add more headers as needed
    };

    try {
      final request =  await http.get(Uri.parse(url), headers: headers);

      // print(request.body);
      if(request.statusCode == 200) {
        // print(request.body);
        final decodedData  =  json.decode(request.body);
        if(decodedData != null) {
          final accountModel =  UserModel.fromJson(decodedData);
          _isLoading = false;
          _resMessage = "Data found successfully";
          return accountModel;
        }

      }
    } on SocketException catch (e) {
      _isLoading = false;
      _resMessage = "Check Your connection and try again";
      print("$_resMessage :  $e");
    } on HttpException catch(e) {
      _isLoading = false;
      _resMessage = "Http exception : $e";

      print(_resMessage);
    } on FormatException catch (e) {
      _isLoading = false;
      _resMessage = "Format Exception : $e";
      print(_resMessage);
    } catch (e){
      _isLoading  = false;
      _resMessage = "Unknown error occured $e";

      print(_resMessage);
    }

    _isLoading = false;
    notifyListeners();
    return UserModel(user: User.fromJson({}));
  }



}