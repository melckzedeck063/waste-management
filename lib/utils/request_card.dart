import 'package:flutter/material.dart';
import 'package:manage_waste/pages/service_delivery_screen.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class RequestCard extends StatelessWidget {

  final String title;
  final String orderNo;
  final String status;
  final String date;
  final String pickupdate;
  final String wasteType;
  final String servicePhoto;
  final dynamic bookedBy;
  final double latitude;
  final double longtude;
  final String  uuid;

  const RequestCard({
    Key?key,
    required this.title,
    required this.orderNo,
    required this.status,
    required this.date,
    required this.pickupdate,
    required this.wasteType,
    required this.servicePhoto,
    required this.bookedBy,
    required this.latitude,
    required this.longtude,
    required this.uuid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // print(bookedBy);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 3),
      decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12)
      ),
      child: ListTile(
        title: Row(
          children: [
            const Text(
              "Service : ",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        subtitle: Column(
          children: [
            Row(
              children: [
                const Text("Order# : ",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(orderNo),
              ],
            ),

            Row(
              children: [
                const Text("Date : ",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(date),
              ],
            )
          ],
        ),
        trailing: Text(status,
        style: TextStyle(
          color: Colors.cyan[800]
        ),
        ),
        onTap: () {
          // Handle tapping on a notification item
          Navigator.push(
              context, 
              MaterialPageRoute(builder: (context)  =>  ServiceDelivery(
                arguments: BookingArguments(
                    title: title,
                 orderNo: orderNo,
                 status : status,
                 date : date,
                    pickupdate: pickupdate,
                     wasteType: wasteType,
                     servicePhoto: servicePhoto,
                  latitude: latitude,
                  longtude: longtude,
                  bookedBy: bookedBy,
                  uuid: uuid
                ),
              ) )
          );
        },
      ),
    );
  }
}
