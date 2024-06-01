import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manage_waste/models/feedbacks_model.dart';
import 'package:manage_waste/pages/feedback_screen.dart';
import 'package:manage_waste/provider/feedbacks_provider.dart';

import '../utils/feedback_card.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final Set<int> expandedFeedbacks = {};

  void toggleExpanded(int index) {
    setState(() {
      if (expandedFeedbacks.contains(index)) {
        expandedFeedbacks.remove(index);
      } else {
        expandedFeedbacks.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'User Feedback',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.send_and_archive, color: Colors.white),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FeedbackScreen())
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<FeedbacksModel>(
          future: FeedbackProvider().getAllFeedbacks(),
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
              final feedbackItems = snapshot.data!.content.map((feedback) {
                return FeedbackItem(
                  username: "${feedback.sentBy['firstName']} ${feedback.sentBy['lastName']}",
                  ratings: feedback.ratings,
                  feedback: feedback.message,
                );
              }).toList();

              if (feedbackItems.isNotEmpty) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  itemCount: feedbackItems.length,
                  itemBuilder: (context, index) {
                    final feedback = feedbackItems[index];
                    return FeedbackCard(
                      feedback: feedback,
                      isExpanded: expandedFeedbacks.contains(index),
                      onTap: () => toggleExpanded(index),
                    );
                  },
                );
              } else {
                return Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 190),
                    child: Text(
                      "No feedback data found",
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
                  "No feedback data found",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class FeedbackItem {
  final String username;
  final String feedback;
  final double ratings;

  FeedbackItem({required this.username, required this.feedback, required this.ratings});
}
