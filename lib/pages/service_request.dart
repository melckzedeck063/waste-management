import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:geocoding/geocoding.dart';
import 'package:manage_waste/provider/booking_provider.dart';
import 'package:provider/provider.dart';
import '../provider/user_details_provider.dart';
import 'package:toastification/toastification.dart';

class ServiceRequest extends StatefulWidget {
  final ServiceArguments arguments;

  const ServiceRequest({
    Key? key,
    required this.arguments,
}): super(key: key);

  @override
  State<ServiceRequest> createState() => _ServiceRequestState();
}

class _ServiceRequestState extends State<ServiceRequest> {

  DateTime selectedDate = DateTime.now();
  String selectedWasteCategory = 'Solid Waste'; // Default value
  String defaultPrice  = "5000";

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

  initState(){
    getCurrentLocation();
    super.initState();
  }

  getCurrentLocation(){
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high, forceAndroidLocationManager: true)
        .then((Position position){
      setState(() {
        currentLocation = position;
        getCurrentAddressFromLatLng();
      });
    }) .catchError((e){
      print(e);
    }) ;
  }

  getCurrentAddressFromLatLng() async {
    try{
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentLocation.latitude,
          currentLocation.longitude
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
        title: const Text("Request Service",
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

                            Text(widget.arguments.serviceName,
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

                const SizedBox(height: 10,),

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
                                  if (currentAddress != "")
                                    Text(currentAddress,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.grey[700]
                                      ),
                                    ),
                                  const SizedBox(height: 7,),
                                  if (currentLocation.latitude != 0.0 &&
                                      currentLocation.latitude != 0.0)
                                    Column(
                                      children: [
                                        Text("LAT: ${(currentLocation.latitude)
                                            .toStringAsFixed(6)}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[800]
                                          ),
                                        ),
                                        Text("LNG : ${(currentLocation.longitude
                                            .toStringAsFixed(4))}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[800]
                                          ),
                                        )
                                      ],
                                    ),

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

                                  FutureBuilder<String>(
                                    future: CurrentUserProvider()
                                        .getFirstName(),
                                    // Future method to get user's first name from shared preferences
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        // Show a loading indicator while waiting for the data
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        // Show an error message if an error occurs
                                        return Text(
                                          'Error: ${snapshot.error}',
                                          style: TextStyle(color: Colors.red),
                                        );
                                      } else {
                                        // Display the user's first name if data is retrieved successfully
                                        return Text(
                                          '${snapshot.data}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.grey[700],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 7,),
                                  FutureBuilder<String>(
                                    future: CurrentUserProvider().getUsername(),
                                    // Future method to get user's first name from shared preferences
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        // Show a loading indicator while waiting for the data
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        // Show an error message if an error occurs
                                        return Text(
                                          'Error: ${snapshot.error}',
                                          style: TextStyle(color: Colors.red),
                                        );
                                      } else {
                                        // Display the user's first name if data is retrieved successfully
                                        return Text(
                                          '${snapshot.data}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[800],
                                          ),
                                        );
                                      }
                                    },
                                  ),
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
                                  Text("Selected Due Date",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.grey[700]
                                    ),
                                  ),
                                  const SizedBox(height: 7,),

                                  GestureDetector(
                                    onTap: () async {
                                      final DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2101),
                                      );
                                      if (pickedDate != null) {
                                        setState(() {
                                          // Update the selected date
                                          selectedDate = pickedDate;
                                        });
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Text(
                                        "${selectedDate.year}-${selectedDate
                                            .month}-${selectedDate.day}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.green[700],
                                        ),
                                      ),
                                    ),
                                  ),
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

                                  DropdownButton<String>(
                                    value: selectedWasteCategory,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedWasteCategory = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      'Solid Waste',
                                      'Liquid Waste',
                                      'Plastics Waste'
                                    ]
                                        .map<DropdownMenuItem<String>>(
                                          (String value) =>
                                          DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[800],
                                              ),
                                            ),
                                          ),
                                    )
                                        .toList(),
                                  ),

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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => const LandingScreen())
                      // );
                      // print(selectedDate);
                      // print(selectedWasteCategory);
                      // print(currentLocation.latitude);
                      // print(currentLocation.longitude.toString());
                      // print(widget.arguments.serviceName);
                      // print(widget.arguments.servicePhoto);
                      // print(defaultPrice);

                      String serviceName = widget.arguments.serviceName;
                      String servicePhoto = widget.arguments.servicePhoto;
                      String servicePrice = defaultPrice;
                      String latitude  =  currentLocation.latitude.toString();
                      String longtude  =  currentLocation.longitude.toString();
                      String pickupd_date =  selectedDate.toString();
                      String wasteType = selectedWasteCategory.toString();


                      book.createBooking(serviceName: serviceName, servicePhoto: servicePhoto, servicePrice: servicePrice, latitude: latitude, longtude: longtude, pickupd_date: pickupd_date, wasteType: wasteType, context: context);

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
                        backgroundColor: Colors.cyan[700],
                        padding: const EdgeInsets.all(8)
                    ),
                    child: const Center(
                        child: Text("Request Now",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        )),
                  ),
                ),


              ],
            ),
          );
        }),
    );
  }
}


class ServiceArguments {
  final  String serviceName;
  final String servicePhoto;


  ServiceArguments(
  {
    required this.serviceName,
    required this.servicePhoto
  }
  );

}