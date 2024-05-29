import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:manage_waste/pages/notifications.dart';
import '../main.dart';

class FirebaseApi {

  // CREATE INSTANCE OF FIREBASE MMESSAGING
  final _firebaseMessaging = FirebaseMessaging.instance;


  // FUNCTION TO INITIALIZE NOTIFICATIONS

Future<void> initNotifications() async {
  NotificationSettings settings =  await _firebaseMessaging.requestPermission();
  await _firebaseMessaging.requestPermission();

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
    final String? fCMToken = await _firebaseMessaging.getToken();

    print("FCM TOKEN : ${fCMToken.toString()}");
  }
}
  // function to handle  received notifications

void handleMessage(RemoteMessage? message){
  if(message == null)
    return;

  navigatorKey.currentState?.pushNamed(
    '/notification_screen',
    arguments: message
  );

}

  // FUNCTION TO INITIALIZE FOREGROUND AND  BACKGROUND SETTINGS

Future initPushNotifications() async{
  FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
}

}