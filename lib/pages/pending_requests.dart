import 'package:flutter/material.dart';
import 'package:manage_waste/utils/request_card.dart';

class PendingRequests extends StatefulWidget {
  const PendingRequests({super.key});

  @override
  State<PendingRequests> createState() => _PendingRequestsState();
}

class _PendingRequestsState extends State<PendingRequests> {

  final List<Map<String,dynamic>> requests = [
  {
  "title": "Order #00456",
  "desc": "Your booking has been placed successfully.",
  "status": "Pending",
  },
  {
  "title": "Order #10496",
  "desc": "Hello the due date is tomorrow and well be there on time",
  "status": "Accepted",
  },
    {
      "title": "Order #03456",
      "desc": "Your booking has been placed successfully.",
      "status": "Pending",
    },
    {
      "title": "Order #20456",
      "desc": "Hello the due date is tomorrow and well be there on time",
      "status": "Accepted",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text("Pending Requests",
             style: TextStyle(
               fontSize: 18,
               fontWeight: FontWeight.bold,
               color: Colors.grey[700]
             ),
            ),
          ),

          Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6),

                child: ListView.builder(
                  itemCount: requests.length,
                    itemBuilder: (context, index) =>
                        RequestCard(
                            title: requests[index]["title"],
                            desc: requests[index]["desc"],
                            status: requests[index]["status"]
                        )
                ),
              )
          ),

          const SizedBox(height: 10,)
        ],
      ),
    );
  }
}
