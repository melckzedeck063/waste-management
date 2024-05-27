import 'dart:async';

import 'package:flutter/material.dart';
import 'package:manage_waste/config/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart' hide LocationAccuracy;
import 'package:geolocator_platform_interface/src/enums/location_accuracy.dart';



class DeliveryScreen extends StatefulWidget {
  final DeliveryArguments  arguments;

  const DeliveryScreen({
    Key ? key,
    required this.arguments
  });

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {

  final Completer<GoogleMapController> _controller  = Completer();

  late LatLng _center;
  late CameraPosition _myPosition;
  bool isLoading  = true;

  static const LatLng sourceLocation = LatLng(-6.1871492323538915, 35.755923355882224);
  // static const LatLng destination = LatLng(-6.188551067565355, 35.777384833128245);

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

  void makePhoneCall(String phone) async {
    final Uri url =  Uri(scheme: 'tel',path: phone);

    if(await canLaunchUrl(url)){
      await launchUrl(url);
    }
    else {
      throw Exception("Could not launch $url");
    }
  }

  List<LatLng> polylineCoordinates  = [];
  // Location? currentLocation;

  // void getCurrentLocation() {
  //   Location location  =  Location();
  //
  //   location.getLocation().then((location) =>
  //    currentLocation = location as Location?
  //   );
  //
  //   print("currentt location: $location");
  // }

  void getPolyyPoints()  async {
    PolylinePoints polylinePoints =  PolylinePoints();

    PolylineResult result = await  polylinePoints.getRouteBetweenCoordinates(
        AppConstants().google_key,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(widget.arguments.latitude, widget.arguments.longtude)
    );

    if(result.points.isNotEmpty){
      result.points.forEach((PointLatLng point) => polylineCoordinates.add(
        LatLng(point.latitude, point.longitude)
      ),
      );

      setState(() {

      });

    }

  }

  @override
  void initState(){
    // getCurrentLocation();
    getPolyyPoints();
    super.initState();
    getCurrentLocation();
  }


  getCurrentLocation(){
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high, forceAndroidLocationManager: true)
        .then((Position position){
      setState(() {
        currentLocation = position;
        // getCurrentAddressFromLatLng();
      });
    }) .catchError((e){
      print(e);
    }) ;
  }

  @override
  Widget build(BuildContext context) {

    // static const LatLng destination = LatLng(-6.188551067565355, 35.777384833128245);
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
        title: const Text("Deliver Service",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
      ),


      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              children: [
                // currentLocation == null ?
                //     const Center(
                //       child: Text("Loading ...."),
                //     )
                // :
                Expanded(
                  flex: 2,
                    child:
                    GoogleMap(
                      initialCameraPosition: const CameraPosition(
                        target: sourceLocation, zoom: 18.5,
                      ),
                      polylines: {
                        Polyline(
                          polylineId: PolylineId("route"),
                          points: polylineCoordinates,
                          color: Colors.blueAccent,
                          width: 6
                        )
                      },
                      markers: {
                         // Marker(
                         //    markerId: const MarkerId("currentLocation"),
                         //    position: LatLng(
                         //      currentLocation!.latitude!,
                         //      currentLocation!.longitude!,
                         //    ),
                         // ),
                        const Marker(
                          markerId: MarkerId("source"),
                          position: sourceLocation),
                         Marker(
                          markerId: const MarkerId("destination"),
                          position: LatLng(widget.arguments.latitude, widget.arguments.longtude),
                        ),
                      },
                      onMapCreated: (mapController){
                        _controller.complete(mapController);
                      },
                    ),
            )
                ]
          ),
        ),
      )
    ),


      bottomNavigationBar: Container(
        height: 215,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)),
          color: Colors.white
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

            const SizedBox(height: 6,),

            Text("Customer Details",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey[700]
              ),
            ),

            const  SizedBox(height: 15,),

            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Telephone",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey[700]
                    ),
                  ),
                  const SizedBox(height: 7,),
                  Row(
                    children: [
                       Container(
                           height: 35,
                           width: 35,
                           decoration: BoxDecoration(
                               color: Colors.grey[300],
                               borderRadius: BorderRadius.circular(50)
                           ),
                           child: GestureDetector(
                             onTap: () {
                               makePhoneCall("+${widget.arguments.bookedBy['phone']}");
                             },
                               child: Icon(Icons.call, size: 24, color: Colors.green[600])
                           )
            ),
                      const SizedBox(width: 5,),
                      Text("+${widget.arguments.bookedBy['phone']}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 10,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Name",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey[700]
                    ),
                  ),
                  const SizedBox(height: 7,),
                  Column(
                    children: [
                      Text( " ${widget.arguments.bookedBy['firstName']} ${widget.arguments.bookedBy['lastName']}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800]
                        ),
                      ),
                      Text(widget.arguments.bookedBy['username'],
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800]
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 14),
            Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 25.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => const DeliveryScreen())
                  // );
                },

                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan[700],
                    padding: const EdgeInsets.all(8)
                ),
                child: const Center(
                    child: Text("Complete Now",
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
      ),
    );
  }
}


class DeliveryArguments {
  String title;
  String date;
  double latitude;
  double longtude;
  dynamic bookedBy;

  DeliveryArguments({
    required this.title,
    required this.date,
    required this.latitude,
    required this.longtude,
    required this.bookedBy
  });
}