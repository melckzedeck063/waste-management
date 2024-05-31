import 'package:flutter/material.dart';
import 'package:manage_waste/pages/admin_pending_requests.dart';
import 'package:manage_waste/pages/pending_requests.dart';

class AllRequests extends StatefulWidget {
  const AllRequests({super.key});

  @override
  State<AllRequests> createState() => _AllRequestsState();
}

class _AllRequestsState extends State<AllRequests> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.cyan[700],
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: const Text('All Requests',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white
            ),
          ),

        ),
        body:  const Column(
          children: [
            // AdminPendingRequests(),
            // Center(child: Text('No data available to display',
            //   style: TextStyle(
            //       fontSize: 24,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.red[300]
            //   ),
            // )),
          ],
        ),
    );
  }
}
