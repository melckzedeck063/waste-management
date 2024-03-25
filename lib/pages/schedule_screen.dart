import 'package:flutter/material.dart';
import 'package:manage_waste/utils/today_shedule.dart';
import 'package:manage_waste/utils/weekly_schedule.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.cyan[700],
          title: const Text(
            "Schedule",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: const [
              Tab(text: 'Today',),
              Tab(text: 'This Week'),
              Tab(text: 'This Month'),
            ],
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.grey[700]
            ),
            indicatorColor: Colors.white, // Color of the selected tab indicator
            indicatorWeight: 3, // Thickness of the selected tab indicator

          ),
        ),
        body: const TabBarView(
          children: [
            TodaySchedule(),
            WeeklySchedule(),
            Center(child: Text('Tab 3 Content')),
          ],
        ),
      ),
    );
  }
}
