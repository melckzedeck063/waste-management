import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:geocoding/geocoding.dart';
import 'package:manage_waste/pages/payment_page2.dart';
import 'package:manage_waste/provider/booking_provider.dart';
import 'package:provider/provider.dart';
import '../provider/user_details_provider.dart';
import 'package:toastification/toastification.dart';

class ServiceRequest extends StatefulWidget {
  final ServiceArguments arguments;

  const ServiceRequest({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<ServiceRequest> createState() => _ServiceRequestState();
}

class _ServiceRequestState extends State<ServiceRequest> {
  DateTime selectedDate = DateTime.now();
  String selectedWasteCategory = 'Solid Waste'; // Default value
  String defaultPrice = "5000";

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
  initState() {
    getCurrentLocation();
    super.initState();
  }

  getCurrentLocation() {
    Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high, forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        currentLocation = position;
        getCurrentAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  getCurrentAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentLocation.latitude, currentLocation.longitude);

      Placemark place = placemarks[0];

      setState(() {
        currentAddress = "${place.locality},${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  bool isValidRequestDay(DateTime date) {
    int dayOfWeek = date.weekday;
    return dayOfWeek == DateTime.monday || dayOfWeek == DateTime.wednesday || dayOfWeek == DateTime.saturday;
  }

  void _navigateToPaymentScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ConfirmServicePayment(),
      ),
    ).then((_) {
      final book = Provider.of<BookingProvider>(context, listen: false);
      if (book.requestSuccessful) {
        submitRequest(context, book);
      }
    });
  }

  void handleRequestNow(BuildContext context, BookingProvider book) {
    if (!isValidRequestDay(selectedDate)) {
      _navigateToPaymentScreen(context);
    } else {
      submitRequest(context, book);
    }
  }

  void submitRequest(BuildContext context, BookingProvider book) {
    String serviceName = widget.arguments.serviceName;
    String servicePhoto = widget.arguments.servicePhoto;
    String servicePrice = defaultPrice;
    String latitude = currentLocation.latitude.toString();
    String longitude = currentLocation.longitude.toString();
    String pickupDate = selectedDate.toString();
    String wasteType = selectedWasteCategory.toString();

    book.createBooking(
        serviceName: serviceName,
        servicePhoto: servicePhoto,
        servicePrice: servicePrice,
        latitude: latitude,
        longtude: longitude,
        pickupd_date: pickupDate,
        wasteType: wasteType,
        context: context);

    Future.delayed(Duration(seconds: 3), () {
      if (book.requestSuccessful == true) {
        toastification.show(
            context: context,
            style: ToastificationStyle.fillColored,
            type: ToastificationType.success,
            description: RichText(text: TextSpan(text: book.resMessage)),
            alignment: Alignment.topRight,
            autoCloseDuration: const Duration(seconds: 4),
            icon: const Icon(Icons.check_circle),
            primaryColor: Colors.green[700],
            backgroundColor: Colors.white);
      } else {
        toastification.show(
            context: context,
            style: ToastificationStyle.fillColored,
            type: ToastificationType.error,
            description: RichText(text: TextSpan(text: book.resMessage)),
            alignment: Alignment.topRight,
            autoCloseDuration: const Duration(seconds: 4),
            icon: const Icon(Icons.cancel, color: Colors.white),
            primaryColor: Colors.red[300],
            backgroundColor: Colors.white);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Request Service",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                        padding: const EdgeInsets.only(top: 1, left: 1),
                        decoration: BoxDecoration(color: Colors.cyan[600]),
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
                        margin: const EdgeInsets.only(top: 1, right: 10, bottom: 2),
                        child: Text(
                          "Service Details",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19, color: Colors.cyan[800]),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 3, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Name: ",
                              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                            ),
                            Text(
                              widget.arguments.serviceName,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700], fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "From: ",
                              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                            ),
                            Text(
                              "09:00 AM",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700], fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "To: ",
                              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                            ),
                            Text(
                              "05:00 AM",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700], fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Cost: ",
                              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                            ),
                            Text(
                              "@ 5000",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700], fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Consumer<BookingProvider>(
        builder: (context, book, child) {
          return Container(
            height: 485,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            margin: const EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select Date",
                    style: TextStyle(
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.cyan[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${selectedDate.toLocal()}".split(' ')[0],
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Select Waste Category",
                    style: TextStyle(
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButton<String>(
                    value: selectedWasteCategory,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedWasteCategory = newValue!;
                      });
                    },
                    items: <String>['Solid Waste', 'Liquid Waste', 'Medical Waste', 'Hazardous Waste']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      handleRequestNow(context, book);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Request Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
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
