import 'package:flutter/material.dart';
import 'package:manage_waste/utils/schedule_card.dart';

class WeeklySchedule extends StatefulWidget {
  const WeeklySchedule({super.key});

  @override
  _WeeklySchedule createState() => _WeeklySchedule();

}
class _WeeklySchedule extends State<WeeklySchedule> {

  final List <Map<String,dynamic>> schedules= [
    {"street" : "Chamwino", "time": "2024-03-30"},
    {"street" : "Makulu", "time": "2024-03-30"},
    {"street" : "Iyumbu", "time": "2024-03-30"},
    {"street" : "Kikuyu", "time": "2024-03-30"},
    {"street" : "Uzunguni", "time": "2024-03-30"},
    {"street" : "Mlezi", "time": "2024-03-30"},
    {"street" : "Chamwino", "time": "2024-03-30"},
    {"street" : "Makulu", "time": "2024-03-30"},
    {"street" : "Iyumbu", "time": "2024-03-30"},
    {"street" : "Kikuyu", "time": "2024-03-30"},
    {"street" : "Uzunguni", "time": "2024-03-30"},
    {"street" : "Mlezi", "time": "2024-03-30"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),

      child: Column(
        children: [
          Text("Weekly Schedules",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700]
            ),
          ),

          const SizedBox(height: 10,),

          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 1),
              child: ListView.builder(
                  itemCount: (schedules.length / 3).ceil(),
                  itemBuilder: (context, index) {
                    final int firstColumn = index * 2;
                    final int secondColumn = firstColumn +  1;
                    final int thirdColumn = firstColumn + 2;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if(firstColumn < schedules.length)
                          ScheduleCard(
                            street: schedules[index]["street"] ?? "",
                            time: schedules[index]["time"] ?? "",
                          ),
                        if(secondColumn < schedules.length)
                          ScheduleCard(
                            street: schedules[secondColumn]["street"] ?? "",
                            time: schedules[secondColumn]["time"] ?? "",
                          ),
                        if(thirdColumn < schedules.length)
                          ScheduleCard(
                            street: schedules[thirdColumn]["street"] ?? "",
                            time: schedules[thirdColumn]["time"] ?? "",
                          ),
                      ],
                    );
                  }
              ),
            ),
          )
        ],
      ) ,
    );
  }
}
