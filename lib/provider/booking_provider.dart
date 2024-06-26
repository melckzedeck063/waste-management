import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:manage_waste/models/bookings_model.dart';
import 'package:manage_waste/pages/my_requests.dart';
import 'package:manage_waste/pages/pending_requests.dart';
import 'package:manage_waste/provider/user_details_provider.dart';
import 'package:manage_waste/pages/HomeScree.dart';
import 'package:manage_waste/pages/admin_pending_requests.dart';

import '../config/URLS.dart';

class BookingProvider extends ChangeNotifier{

  final RequestUrl = AppUrls.BaseUrl;


  bool _isLoading = false;
  bool _requestSuccessful = false;
  String _resMessage = "";
  bool _isError = true;


  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;
  bool get requestSuccessful =>  _requestSuccessful;
  bool get isError => _isError;

  void createBooking({
    required String serviceName,
    required String servicePhoto,
    required String servicePrice,
    required String latitude,
    required String longtude,
    required String pickupd_date,
    required String wasteType,
    required BuildContext context
}) async{

    String url =  "$RequestUrl/bookings/create-update";

    final body = {
      "pickupd_date": pickupd_date,
      "serviceName": serviceName,
      "servicePhoto": servicePhoto,
      "servicePrice": servicePrice,
      "latitude" : latitude,
      "longtude" : longtude,
      "wasteType" : wasteType
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

        if (respo["error"] == false) {
          _requestSuccessful = true;
          _isLoading = false;
          _isError = false;
          _resMessage = respo['message'];

          Future.delayed(const Duration(seconds: 5),(){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PendingRequests())
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


  Future<BookingModel> getAllBookings()async{
    _isLoading = true;
    notifyListeners();

    final token =  await CurrentUserProvider().getToken();

    String url =  "$RequestUrl/bookings/get";

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


   initiatePaymment({
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

      print(respo);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // final Map<String, dynamic> respo = json.decode(response.body);
        // print(respo);

        if (respo["success"] == true) {
          _requestSuccessful = true;
          _isLoading = false;
          _isError = false;
          _resMessage = respo['message'];

          sendNotification(tittle: "Manage Waste", message: _resMessage, FCMtoken: FCMtoken, context: context);
          Future.delayed(const Duration(seconds: 5),(){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen())
            );
          });
        } else {
          _requestSuccessful = false;
          _resMessage = "Request failed! try again later";
          _isError = true;
          _isLoading = false;
        }
      } else {
        final String res = response.body;
        print("response : $res");
        _isLoading = false;
        _resMessage = "Request failed! try again later";
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
      _resMessage = "Request failed! Please try again later";
      print(_resMessage);
    } catch (e) {
      _isLoading = false;
      _requestSuccessful = false;
      _resMessage = "An unexpected error occurred: $e";
      print(_resMessage);
    }

  }


   updateBookingStatus({
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
                MaterialPageRoute(builder: (context) => const HomeScreen())
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
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => const PendingRequests())
            // );
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


  void sendReminder({
    required String tittle,
    required String message,
    required String userId,
    required String bookingUuid,
    required String status,

    required BuildContext context
  }) async{

    String url =  "$RequestUrl/notifications/new";
    final FCMtoken =  await CurrentUserProvider().getNotificationToken();

    final body = {
      "tittle": tittle,
      "sentTo": userId,
      "message": message,
      "bookingUuid": bookingUuid,
      "status": status,
      "token" : FCMtoken

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

          Future.delayed(const Duration(seconds: 3),(){
            updateBookingStatus(bookingUuid: bookingUuid, status: status, message: "Booking accepted successful", context: context);
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => const AdminPendingRequests())
            // );
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


}