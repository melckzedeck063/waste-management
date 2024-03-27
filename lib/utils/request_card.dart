import 'package:flutter/material.dart';

class RequestCard extends StatelessWidget {

  final String title;
  final String desc;
  final String status;
  const RequestCard({
    Key?key,
    required this.title,
    required this.desc,
    required this.status
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 3),
      decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12)
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(desc),
        trailing: Text(status,
        style: TextStyle(
          color: Colors.cyan[800]
        ),
        ),
        onTap: () {
          // Handle tapping on a notification item
        },
      ),
    );
  }
}
