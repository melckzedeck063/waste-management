import 'package:flutter/material.dart';

class SingleIntroScreen extends StatelessWidget {
  final String title;
  final String description;
  final TextStyle textStyle;

  const SingleIntroScreen({
    Key? key,
    required this.title,
    required this.description,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: textStyle.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
