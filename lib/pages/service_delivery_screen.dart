import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:manage_waste/pages/confirm_payment.dart';
import 'package:manage_waste/pages/delivery_screen.dart';
import 'package:manage_waste/provider/booking_provider.dart';
import 'package:manage_waste/provider/user_details_provider.dart';
import 'package:toastification/toastification.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';


class ServiceDelivery extends StatefulWidget {
  final BookingArguments  arguments;

  const ServiceDelivery({
    Key? key,
    required  this.arguments
});

  @override
  State<ServiceDelivery> createState() => _ServiceRequestState();
}

class _ServiceRequestState extends State<ServiceDelivery> {

  bool showVisitButton = false;

  late String currentAddress = "";
  late Position currentLocation = Position(
    latitude: 0.0,
    longitude: 0.0,
    timestamp: DateTime.now(),
    accuracy: 0.0,
    altitude: 0.0,
    altitudeAccuracy: 0.0,
    heading: 0.0,
    headingAccuracy: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0,
  );

  @override
  void initState() {
    checkUserRole();
    getCurrentAddressFromLatLng();
    super.initState();
  }

  void  checkUserRole() async {
    String role =  await CurrentUserProvider().getUserRole();
    // print("ROLE : $role");
    setState(() {
      showVisitButton = (role == "ADMIN" || role == "SUPER_ADMIN");
    });
  }

  getCurrentAddressFromLatLng() async {
    try{
      List<Placemark> placemarks = await placemarkFromCoordinates(
          widget.arguments.latitude,
          widget.arguments.longtude
      );

      Placemark place = placemarks[0];

      setState(() {
        currentAddress = "${place.locality},${place.postalCode}, ${place.country}";
      });

    }catch (e){
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {

    // print( "LAT :  ${widget.arguments.latitude}");

    return Scaffold(
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
        title: const Text("Request Details",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
      ),

      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10,  vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 1,left: 1),
                        decoration: BoxDecoration(
                            color: Colors.cyan[600]
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20)),
                          child: Image.asset(
                            widget.arguments.servicePhoto,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 1,right: 10, bottom: 2),
                        child: Text("Service Details",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                              color: Colors.cyan[800]
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 3,right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Name: ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700]
                              ),
                            ),

                            Text(widget.arguments.title,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 10,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("From: ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700]
                              ),
                            ),

                            Text("09:00 AM",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 10,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("T0: ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700]
                              ),
                            ),

                            Text("05:00 AM",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 10,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Cost: ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700]
                              ),
                            ),

                            Text("@ 5000",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      )

                    ],
                  ),

                ],
              ),

              const  SizedBox(height: 20,),


            ],
          ),

        ),
      ),

      bottomNavigationBar: Consumer<BookingProvider>(
        builder: (context, book, child) {
          return Container(
            height: 485,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30), topRight: Radius.circular(30))
            ),

            child: Column(
              children: [
                Container(
                  width: 180,
                  height: 5,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                      color: Colors.cyan[800]
                  ),
                ),

                const SizedBox(height: 8,),

                Text("Request Details",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.grey[700]
                  ),
                ),

                const SizedBox(height: 15,),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 3, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 28,
                                  width: 28,
                                  decoration: BoxDecoration(
                                      color: Colors.cyan[700],
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: const Icon(
                                    Icons.location_on, color: Colors.white,
                                    size: 24,),
                                ),
                                Container(
                                  height: 40,
                                  width: 5,
                                  decoration: BoxDecoration(
                                    color: Colors.cyan[800],
                                  ),
                                )
                              ],
                            ),

                            Container(
                              margin: const EdgeInsets.only(right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(currentAddress,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.grey[700]
                                    ),
                                  ),
                                  const SizedBox(height: 7,),
                                  Text("LAT : ${(widget.arguments.latitude)
                                      .toStringAsFixed(5)}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[800]
                                    ),

                                  ),
                                  Text("LNG : ${widget.arguments.longtude}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[800]
                                    ),

                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 3, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 28,
                                  width: 28,
                                  decoration: BoxDecoration(
                                      color: Colors.cyan[700],
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: const Icon(
                                    Icons.person_2_rounded, color: Colors.white,
                                    size: 24,),
                                ),
                                Container(
                                  height: 40,
                                  width: 5,
                                  decoration: BoxDecoration(
                                    color: Colors.cyan[800],
                                  ),
                                )
                              ],
                            ),

                            Container(
                              margin: const EdgeInsets.only(right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text("Pickup Location",
                                  //  textAlign: TextAlign.center,
                                  //  style: TextStyle(
                                  //    fontWeight: FontWeight.bold,
                                  //    fontSize: 16,
                                  //    color: Colors.grey[800]
                                  //  ),
                                  // ),
                                  Text("${widget.arguments
                                      .bookedBy['firstName']} ${widget.arguments
                                      .bookedBy['lastName']}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.grey[700]
                                    ),
                                  ),
                                  const SizedBox(height: 7,),
                                  Text("+${widget.arguments.bookedBy['phone']}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[800]
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 3, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 28,
                                  width: 28,
                                  decoration: BoxDecoration(
                                      color: Colors.cyan[700],
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: const Icon(
                                    Icons.date_range, color: Colors.white,
                                    size: 24,),
                                ),
                                Container(
                                  height: 40,
                                  width: 5,
                                  decoration: BoxDecoration(
                                    color: Colors.cyan[800],
                                  ),
                                )
                              ],
                            ),

                            Container(
                              margin: EdgeInsets.only(right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Scheduled Date",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.grey[700]
                                    ),
                                  ),
                                  const SizedBox(height: 7,),
                                  Text(widget.arguments.pickupdate.substring(
                                      0, 10),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[800]
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 3, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 28,
                                  width: 28,
                                  decoration: BoxDecoration(
                                      color: Colors.cyan[700],
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: const Icon(
                                    Icons.recycling, color: Colors.white,
                                    size: 24,),
                                ),
                                Container(
                                  height: 40,
                                  width: 5,
                                  decoration: BoxDecoration(
                                    color: Colors.cyan[800],
                                  ),
                                )
                              ],
                            ),

                            Container(
                              margin: EdgeInsets.only(right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Waste Category",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.grey[700]
                                    ),
                                  ),
                                  const SizedBox(height: 7,),
                                  Text(widget.arguments.wasteType,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[800]
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),


                const SizedBox(height: 10),

                if(showVisitButton)
                  if(widget.arguments.status == "CONFIRMED")
                    // if(widget.arguments.status == "RECEIVED")
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                DeliveryScreen(
                                  arguments: DeliveryArguments(
                                    title: widget.arguments.title,
                                    date: widget.arguments.date,
                                    latitude: widget.arguments.latitude,
                                    longtude: widget.arguments.longtude,
                                    bookedBy: widget.arguments.bookedBy,

                                  ),
                                ))
                        );
                      },

                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan[700],
                          padding: const EdgeInsets.all(8)
                      ),
                      child: const Center(
                          child: Text("Visit Now",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          )),
                    ),
                  ),

                if(!showVisitButton)
                  if(widget.arguments.status != "CONFIRMED")
                    if(widget.arguments.status != "RECEIVED")
                  Row(
                    children: [
                      Container(
                        width: 170,
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: ElevatedButton(
                          onPressed: () {

                            String status="CANCELLED";
                            String message = "Booking cancelled successful";
                            String uuid  = widget.arguments.uuid;

                            book.updateBookingStatus(bookingUuid: uuid, status: status, message: message, context: context);

                            Future.delayed(Duration(seconds: 3), (){
                              if(book.requestSuccessful == true) {
                                toastification.show(
                                    context: context,
                                    style: ToastificationStyle.fillColored,
                                    type: ToastificationType.success,
                                    description: RichText(text: TextSpan(text: book.resMessage)),
                                    alignment: Alignment.topRight,
                                    autoCloseDuration: const Duration(seconds: 4),
                                    icon: const Icon(Icons.check_circle),
                                    primaryColor: Colors.green[700],
                                    backgroundColor: Colors.white
                                );

                              }
                              else {
                                toastification.show(
                                    context: context,
                                    style: ToastificationStyle.fillColored,
                                    type: ToastificationType.error,
                                    description: RichText(text: TextSpan(text: book.resMessage)),
                                    alignment: Alignment.topRight,
                                    autoCloseDuration: const Duration(seconds: 4),
                                    icon: const Icon(Icons.cancel, color: Colors.white,),
                                    primaryColor: Colors.red[300],
                                    backgroundColor: Colors.white
                                );
                              }
                            });

                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[300],
                            padding: const EdgeInsets.all(8),
                            animationDuration: const Duration(seconds: 2),
                          ),
                          child: const Center(
                              child: Text("Cancel Order",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      ),


                      Container(
                        width: 170,
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: ElevatedButton(
                          onPressed: () {
                            String status="CONFIRMED";
                            String message = "Booking confirmed successful";
                            String uuid  = widget.arguments.uuid;

                            book.updateBookingStatus(bookingUuid: uuid, status: status, message: message, context: context);

                            Future.delayed(Duration(seconds: 3), (){
                              if(book.requestSuccessful == true) {
                                toastification.show(
                                    context: context,
                                    style: ToastificationStyle.fillColored,
                                    type: ToastificationType.success,
                                    description: RichText(text: TextSpan(text: book.resMessage)),
                                    alignment: Alignment.topRight,
                                    autoCloseDuration: const Duration(seconds: 4),
                                    icon: const Icon(Icons.check_circle),
                                    primaryColor: Colors.green[700],
                                    backgroundColor: Colors.white
                                );
                              }
                              else {
                                toastification.show(
                                    context: context,
                                    style: ToastificationStyle.fillColored,
                                    type: ToastificationType.error,
                                    description: RichText(text: TextSpan(text: book.resMessage)),
                                    alignment: Alignment.topRight,
                                    autoCloseDuration: const Duration(seconds: 4),
                                    icon: const Icon(Icons.cancel, color: Colors.white,),
                                    primaryColor: Colors.red[300],
                                    backgroundColor: Colors.white
                                );
                              }
                            });
                          },

                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[600],
                              padding: const EdgeInsets.all(8),
                              animationDuration: const Duration(seconds: 3)
                          ),
                          child: const Center(
                              child: Text("Confirm Order",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              )),
                        ),
                      ),
                    ],
                  )

              ],
            ),
          );
        }
      ),
    );
  }
}


class BookingArguments {
   String uuid;
   String title;
   String orderNo;
   String status;
   String date;
   String pickupdate;
   String wasteType;
   String servicePhoto;
   double latitude;
   double longtude;
  dynamic bookedBy;

  BookingArguments({
    required this.uuid,
    required this.title,
    required this.orderNo,
    required this.status,
    required this.date,
    required this.pickupdate,
    required this.wasteType,
    required this.servicePhoto,
    required this.latitude,
    required this.longtude,
    required this.bookedBy
  });

}