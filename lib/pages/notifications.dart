import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:manage_waste/models/notifications_model.dart';

import '../provider/feedbacks_provider.dart';

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
      body: FutureBuilder<NotificationsModel>(
        future: FeedbackProvider().getAllMessages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: CupertinoColors.activeGreen,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.red[300],
                ),
              ),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            final data = snapshot.data!.content;
            if (data.isNotEmpty) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 6),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final notification = data[index];
                  return NotificationItem(
                      title: notification.title,
                      message: notification.message,
                      time: notification.createdAt.toString()
                  );
                },
              );
            } else {
              return Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 190),
                  child: Text(
                    "No notification found",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.red[300],
                    ),
                  ),
                ),
              );
            }
          } else {
            return const Center(
              child: Text(
                "No notification  data found",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            );
          }
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
      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 3),
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
        trailing: Text(time.substring(11,16)),
        onTap: () {
          // Handle tapping on a notification item
        },
      ),
    );
  }
}