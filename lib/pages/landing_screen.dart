import 'package:flutter/material.dart';
import 'package:manage_waste/pages/HomeScree.dart';
import 'package:manage_waste/pages/history_screen.dart';
import 'package:manage_waste/pages/pricing_page.dart';
import 'package:manage_waste/pages/schedule_screen.dart';
import 'package:manage_waste/pages/updates_page.dart';


class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {

  int selectedScreen = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const UpdatesScreen(),
    const HistoryScreen(),
    const  PricingPages()
  ];

  void changeScreen(int index){
    setState(() {
      selectedScreen = index;
    });
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
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks_outlined),
            label: "Schedule",
          ),
        ],
        currentIndex: selectedScreen,
        selectedItemColor: Colors.white,
        onTap: changeScreen,
      ),
    );
  }
}
