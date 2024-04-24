import 'package:flutter/material.dart';
import 'package:manage_waste/pages/pending_requests.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.cyan[700],
          title: const Text('My Requests',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white
            ),
          ),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: const [
              Tab(text: 'Pending',),
              Tab(text: 'Completed'),
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
            PendingRequests(),
            Center(child: Text('Completed Requests')),
          ],
        ),
      ),
    );
  }
}
