import 'package:flutter/material.dart';
import 'package:manage_waste/pages/HomeScree.dart';
import 'package:manage_waste/pages/feedback_screen.dart';
import 'package:manage_waste/pages/feedbacks_page.dart';
import 'package:manage_waste/pages/history_screen.dart';
import 'package:manage_waste/pages/payment_intro.dart';
import 'package:manage_waste/pages/pending_requests.dart';
import 'package:manage_waste/pages/pricing_page.dart';
import 'package:manage_waste/pages/schedule_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:manage_waste/pages/updates_page.dart';


class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {

  int selectedScreen = 0;
  bool _locationServiceEnabled = false;

  final List<Widget> screens = [
    const HomeScreen(),
    const UpdatesScreen(),
    const PendingRequests(),
    FeedbackPage()
  ];

  void changeScreen(int index){
    setState(() {
      selectedScreen = index;
    });
  }

  @override
  void initState(){
    super.initState();
    _checkLocationService();
  }

  Future<void> _checkLocationService() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await Geolocator.openLocationSettings();
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    setState(() {
      _locationServiceEnabled = serviceEnabled && permission == LocationPermission.always;
    });
    if (_locationServiceEnabled) {
      // Navigate to the next screen
      // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: screens[selectedScreen],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.cyan[700],
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: "Updates",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "My Requests",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            label: "Feedbacks",
          ),
        ],
        currentIndex: selectedScreen,
        selectedItemColor: Colors.white,
        onTap: changeScreen,
      ),
    );
  }
}
