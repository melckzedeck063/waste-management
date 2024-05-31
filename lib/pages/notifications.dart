import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationScreen extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = [
    {
      "title": "New Message",
      "message": "You booking has been accepted.",
      "time": "10:30 AM",
    },
    {
      "title": "Reminder",
      "message": "Hello the due date is tomorrow and well be there  on time",
      "time": "tomorrow",
    },
    // Add more notifications as needed
  ];

  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // final message  =  ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text('Notifications',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return NotificationItem(
            title: notification['title'],
            message: notification['message'],
            time: notification['time'],
          );
        },
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String message;
  final String time;

  const NotificationItem({
    required this.title,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12)
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(message),
        trailing: Text(time),
        onTap: () {
          // Handle tapping on a notification item
        },
      ),
    );
  }
}