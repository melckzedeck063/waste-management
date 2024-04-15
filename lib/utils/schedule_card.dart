import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final String street;
  final String time;

  const ScheduleCard({
   Key? key,
    required this.street,
    required this.time
  }) :super(key: key) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white
      ),

      child: Column(
        children: [
          Text(street,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.grey[800]
          ),
          ),
          const SizedBox(height: 8,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.watch_later_rounded,color: Colors.cyan[800],size: 20),
              Text(time,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.grey[800]
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
