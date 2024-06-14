import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:manage_waste/models/bookings_model.dart';
import 'package:manage_waste/models/feedbacks_model.dart';
import 'package:manage_waste/models/notifications_model.dart';
import 'package:manage_waste/pages/my_requests.dart';
import 'package:manage_waste/provider/user_details_provider.dart';
import 'package:manage_waste/pages/feedbacks_page.dart';


import '../config/URLS.dart';

class FeedbackProvider extends ChangeNotifier{

  final RequestUrl = AppUrls.BaseUrl;


  bool _isLoading = false;
  bool _requestSuccessful = false;
  String _resMessage = "";
  bool _isError = true;


  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;
  bool get requestSuccessful =>  _requestSuccessful;
  bool get isError => _isError;

  void createFeedback({
    required String message,
    required double ratings,
    required BuildContext context
  }) async{

    String url =  "$RequestUrl/feedbacks/post";

    final body = {
      "message": message,
      "ratings": ratings,
    };

    final token = await CurrentUserProvider().getToken();

    final Map<String,String> headers = {
      "Content-Type":"application/json",
      "Authorization" : "Bearer $token"
    };

    print(body);


    try {
      http.Response response = await http.post(Uri.parse(url), headers: headers, body: json.encode(body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> respo = json.decode(response.body);

        print(respo);
        if (respo["error"] == false) {
          _requestSuccessful = true;
          _isLoading = false;
          _isError = false;
          _resMessage = respo['message'];

          Future.delayed(const Duration(seconds: 5),(){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  FeedbackPage())
            );
          });
        } else {
          _requestSuccessful = false;
          _resMessage = respo['message'];
          _isError = true;
          _isLoading = false;
        }
      } else {
        final String res = response.body;
        print("response : $res");
        _isLoading = false;
        _requestSuccessful = false;
        notifyListeners();
      }
    } on SocketException catch (e) {
      _isLoading = false;
      _resMessage = "Connection error";
      print("Socket Exception : $e");
    } on HttpException catch (e) {
      _isLoading = false;
      _resMessage = "Http Exception: $e";
      print(_resMessage);
    } on FormatException catch (e) {
      _isLoading = false;
      _resMessage = "Response format error $e";
      print(_resMessage);
    } catch (e) {
      _isLoading = false;
      _requestSuccessful = false;
      _resMessage = "An unexpected error occurred: $e";
      print(_resMessage);
    }

  }


  Future<BookingModel> getMyBookings()async{
    _isLoading = true;
    notifyListeners();

    final token =  await CurrentUserProvider().getToken();

    String url =  "$RequestUrl/bookings/get-my-bookings";

    final Map<String,String> headers = {
      "Content-Type":  "application/json",
      "Authorization" : "Bearer $token"
    };

    try{

      final request =  await http.get(Uri.parse(url), headers: headers);

      if(request.statusCode == 200){
        final decodedData =  json.decode(request.body);

        // print(decodedData);

        if(decodedData != null){
          final bookingModel =  BookingModel.fromJson(decodedData);
          _isLoading = false;
          _resMessage = "data found";
          return bookingModel;
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
    return BookingModel(content: []);

  }


  Future<FeedbacksModel> getAllFeedbacks()async{
    _isLoading = true;
    notifyListeners();

    final token =  await CurrentUserProvider().getToken();

    String url =  "$RequestUrl/feedbacks/by-ratings";

    final Map<String,String> headers = {
      "Content-Type":  "application/json",
      "Authorization" : "Bearer $token"
    };

    try{

      final request =  await http.get(Uri.parse(url), headers: headers);

      if(request.statusCode == 200){
        final decodedData =  json.decode(request.body);

        // print(decodedData);

        if(decodedData != null){
          final feedbackModel =  FeedbacksModel.fromJson(decodedData);
          _isLoading = false;
          _resMessage = "data found";
          return feedbackModel;
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
    return FeedbacksModel(content: []);

  }


  void initiatePaymment({
    required String accountNumber,
    required String amount,
    required String provider,
    required String currency,
    required String externalId,
    required BuildContext context
  }) async{

    String url =  "$RequestUrl/payments/checkout";

    final body = {
      "accountNumber": accountNumber,
      "amount": amount,
      "provider": provider,
      "currency" : currency,
      "externalId" : externalId,
    };

    final token = await CurrentUserProvider().getToken();
    final FCMtoken =  await CurrentUserProvider().getNotificationToken();


    final Map<String,String> headers = {
      "Content-Type":"application/json",
      "Authorization" : "Bearer $token"
    };

    try {
      http.Response response = await http.post(Uri.parse(url), headers: headers, body: json.encode(body));

      final Map<String, dynamic> respo = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> respo = json.decode(response.body);

        if (respo["success"] == true) {
          _requestSuccessful = true;
          _isLoading = false;
          _isError = false;
          _resMessage = respo['message'];

          sendNotification(tittle: "Manage Waste", message: _resMessage, FCMtoken: FCMtoken, context: context);
          Future.delayed(const Duration(seconds: 5),(){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyRequests())
            );
          });
        } else {
          _requestSuccessful = false;
          _resMessage = respo['message'];
          _isError = true;
          _isLoading = false;
        }
      } else {
        final String res = response.body;
        print("response : $res");
        _isLoading = false;
        _requestSuccessful = false;
        notifyListeners();
      }
    } on SocketException catch (e) {
      _isLoading = false;
      _resMessage = "Connection error";
      print("Socket Exception : $e");
    } on HttpException catch (e) {
      _isLoading = false;
      _resMessage = "Http Exception: $e";
      print(_resMessage);
    } on FormatException catch (e) {
      _isLoading = false;
      _resMessage = "Response format error $e";
      print(_resMessage);
    } catch (e) {
      _isLoading = false;
      _requestSuccessful = false;
      _resMessage = "An unexpected error occurred: $e";
      print(_resMessage);
    }

  }


  void updateBookingStatus({
    required String bookingUuid,
    required String status,
    required String message,

    required BuildContext context
  }) async{

    String url =  "$RequestUrl/bookings/update-booking";

    final body = {
      "bookingUuid": bookingUuid,
      "status": status,
      "message": message,
    };

    final token = await CurrentUserProvider().getToken();
    final FCMtoken =  await CurrentUserProvider().getNotificationToken();

    final Map<String,String> headers = {
      "Content-Type":"application/json",
      "Authorization" : "Bearer $token"
    };

    print(body);


    try {
      http.Response response = await http.put(Uri.parse(url), headers: headers, body: json.encode(body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> respo = json.decode(response.body);

        print(respo);
        if (respo["error"] == false) {
          _requestSuccessful = true;
          _isLoading = false;
          _isError = false;
          _resMessage = respo['message'];

          sendNotification(tittle: "Manage Waste", message: _resMessage, FCMtoken: FCMtoken, context: context);

          Future.delayed(const Duration(seconds: 5),(){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyRequests())
            );
          });
        } else {
          _requestSuccessful = false;
          _resMessage = respo['message'];
          _isError = true;
          _isLoading = false;
        }
      } else {
        final String res = response.body;
        print("response : $res");
        _isLoading = false;
        _requestSuccessful = false;
        notifyListeners();
      }
    } on SocketException catch (e) {
      _isLoading = false;
      _resMessage = "Connection error";
      print("Socket Exception : $e");
    } on HttpException catch (e) {
      _isLoading = false;
      _resMessage = "Http Exception: $e";
      print(_resMessage);
    } on FormatException catch (e) {
      _isLoading = false;
      _resMessage = "Response format error $e";
      print(_resMessage);
    } catch (e) {
      _isLoading = false;
      _requestSuccessful = false;
      _resMessage = "An unexpected error occurred: $e";
      print(_resMessage);
    }

  }

  void sendNotification({
    required String tittle,
    required String message,
    required String FCMtoken,

    required BuildContext context
  }) async{

    String url =  "$RequestUrl/notifications/send";

    final body = {
      "tittle": tittle,
      "token": FCMtoken,
      "message": message,
    };

    final token = await CurrentUserProvider().getToken();

    final Map<String,String> headers = {
      "Content-Type":"application/json",
      "Authorization" : "Bearer $token"
    };

    print(body);


    try {
      http.Response response = await http.post(Uri.parse(url), headers: headers, body: json.encode(body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> respo = json.decode(response.body);

        print(respo);
        if (respo["error"] == false) {
          _requestSuccessful = true;
          _isLoading = false;
          _isError = false;
          _resMessage = respo['message'];

          Future.delayed(const Duration(seconds: 5),(){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyRequests())
            );
          });
        } else {
          _requestSuccessful = false;
          _resMessage = respo['message'];
          _isError = true;
          _isLoading = false;
        }
      } else {
        final String res = response.body;
        print("response : $res");
        _isLoading = false;
        _requestSuccessful = false;
        notifyListeners();
      }
    } on SocketException catch (e) {
      _isLoading = false;
      _resMessage = "Connection error";
      print("Socket Exception : $e");
    } on HttpException catch (e) {
      _isLoading = false;
      _resMessage = "Http Exception: $e";
      print(_resMessage);
    } on FormatException catch (e) {
      _isLoading = false;
      _resMessage = "Response format error $e";
      print(_resMessage);
    } catch (e) {
      _isLoading = false;
      _requestSuccessful = false;
      _resMessage = "An unexpected error occurred: $e";
      print(_resMessage);
    }

  }


  Future<NotificationsModel> getAllMessages()async{
    _isLoading = true;
    notifyListeners();

    final token =  await CurrentUserProvider().getToken();

    String url =  "$RequestUrl/notifications/mine";

    final Map<String,String> headers = {
      "Content-Type":  "application/json",
      "Authorization" : "Bearer $token"
    };

    try{

      final request =  await http.get(Uri.parse(url), headers: headers);

      if(request.statusCode == 200){
        final decodedData =  json.decode(request.body);

        // print(decodedData);

        if(decodedData != null){
          final notificatiomModel =  NotificationsModel.fromJson(decodedData);
          _isLoading = false;
          _resMessage = "data found";
          return notificatiomModel;
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
    return NotificationsModel(content: []);

  }


}