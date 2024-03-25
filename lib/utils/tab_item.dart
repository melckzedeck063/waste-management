import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final String category;
  final bool isSelected;
  final VoidCallback onTap;

  TabItem({
    Key? key,
    required this.category,
    required  this.isSelected,
    required this.onTap,
  }) : super(key: key);

  Color custom_green = const Color(0xB0D9B1);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.green[600],
            borderRadius: BorderRadius.circular(5),

        ),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.only(left: 10.0,right: 10, top: 5),
        child: Text(category,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected? Colors.orange : Colors.white
          ),
        ),
      ),
    );
  }
}
