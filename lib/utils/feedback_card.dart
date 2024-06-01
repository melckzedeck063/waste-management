import 'package:flutter/material.dart';

import '../pages/feedbacks_page.dart';

class FeedbackCard extends StatelessWidget {
  final FeedbackItem feedback;
  final bool isExpanded;
  final VoidCallback onTap;

  const FeedbackCard({
    Key? key,
    required this.feedback,
    required this.isExpanded,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    feedback.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(right: 8),
                          child: const Icon(Icons.star, color: Colors.orange, size: 24,)),
                      Text(
                        feedback.ratings.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 8),
              Text(
                isExpanded || feedback.feedback.length <= 120
                    ? feedback.feedback
                    : '${feedback.feedback.substring(0, 120)}...',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
              ),
              if (feedback.feedback.length > 120)
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    isExpanded ? 'Show less' : 'Read more',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
