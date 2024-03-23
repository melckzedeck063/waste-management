import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: Text("History",
          style : TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold
          )
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Center(
                child: Text("History"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
