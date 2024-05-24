import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manage_waste/models/bookings_model.dart';
import 'package:manage_waste/provider/booking_provider.dart';
import 'package:manage_waste/utils/request_card.dart';

class AdminPendingRequests extends StatefulWidget {
  const AdminPendingRequests({super.key});

  @override
  State<AdminPendingRequests> createState() => _PendingRequestsState();
}

class _PendingRequestsState extends State<AdminPendingRequests> {

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

          FutureBuilder<BookingModel>(
              future: BookingProvider().getAllBookings(),
              builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(
                    child: CircularProgressIndicator(
                      color: CupertinoColors.activeGreen,
                    ),
                  );
                }
                else if(snapshot.hasError){
                  return Center(
                    child: Text("Error : ${snapshot.error}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.red[300]
                      ),
                    ),
                  );
                }
                else if(snapshot.hasData && snapshot.data != null){
                  final data =  snapshot.data!.content;
                  if(data.isNotEmpty){
                    return   Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 6),

                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final booking  = data[index];
                                return  RequestCard(
                                  title: booking.serviceName,
                                  orderNo: booking.uuid.substring(0,6).toUpperCase(),
                                  status: booking.status,
                                  date: booking.createdAt.toString().substring(0,20),
                                  pickupdate: booking.pickupDate,
                                  wasteType: booking.wasteType,
                                  servicePhoto: booking.servicePhoto,
                                  bookedBy: booking.bookedBy,
                                  latitude: booking.latitude,
                                  longtude: booking.longtude,

                                );
                              }

                          ),
                        )
                    );
                  }
                  else {
                    return  Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 190),
                        child: Text(
                          "No booking data found",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20,
                              color: Colors.red[300]
                          ),
                        ),
                      ),
                    );
                  }
                }
                else {
                  return const Center(
                    child: Text(
                      "No booking data found",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  );
                }
              }
          ),



          const SizedBox(height: 10,)
        ],
      ),
    );
  }
}
