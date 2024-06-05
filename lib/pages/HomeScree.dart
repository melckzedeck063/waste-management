import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manage_waste/pages/about_us_page.dart';
import 'package:manage_waste/pages/admin_pending_requests.dart';
import 'package:manage_waste/pages/notifications.dart';
import 'package:manage_waste/pages/payment_intro.dart';
import 'package:manage_waste/pages/privacy_page.dart';
import 'package:manage_waste/pages/terms_uses_page.dart';
import 'package:manage_waste/pages/user_profile.dart';
import 'package:manage_waste/provider/user_details_provider.dart';
import 'package:manage_waste/utils/service_card.dart';
import 'package:manage_waste/utils/welcome_banner.dart';

import '../utils/intro_screen.dart';
import '../utils/service_card2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List services =[
    {"name": "Recycling", "image" : "lib/icons/recycle-bin.png"},
    {"name": "Incinerating", "image" : "lib/icons/tank.png"},
    {"name": "Waste Collecting", "image" : "lib/icons/truck.png"},
  ];

  bool showAdminItems = false;
  final PageController _pageController = PageController();
  Timer? _timer;

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_pageController.page!.round() + 1) % 3;
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkUserRole();
    _startAutoScroll();
  }

  void checkUserRole() async {
    String role =  await CurrentUserProvider().getUserRole();

    setState(() {
      showAdminItems = (role == "ADMIN" || role == "SUPER_ADMIN");
    });
  }

  @override
  void dispose(){
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.cyan[700],
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                Navigator.of(context).pop();
                CurrentUserProvider().logoutUser(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.orange[500]),
            onPressed: () {
              _showLogoutConfirmationDialog(context);
            },
          )
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        backgroundColor: Colors.cyan[700],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Container(
                height: 70,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  children: [
                    Icon(Icons.person_2_rounded, size: 64, color: Colors.cyan[100]),
                    FutureBuilder<String>(
                      future: CurrentUserProvider().getUsername(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text(
                            'Error: ${snapshot.error}',
                            style: TextStyle(color: Colors.red),
                          );
                        } else {
                          return Text(
                            '${snapshot.data}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            if (showAdminItems)
              ListTile(
                leading: const Icon(Icons.shopping_cart, color: Colors.white),
                title: const Text(
                  "Requests",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AdminPendingRequests()));
                },
              ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text(
                "My Account",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            if (!showAdminItems)
              ListTile(
                leading: const Icon(Icons.money, color: Colors.white),
                title: const Text(
                  "Billing",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PaymentIntroductionScreen()),
                  );
                },
              ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.white),
              title: const Text(
                "About",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip, color: Colors.white),
              title: const Text(
                "Privacy Policy",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.policy, color: Colors.white),
              title: const Text(
                "Terms of Service",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TermsOfUsePage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.cyan[700],
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder<String>(
                            future: CurrentUserProvider().getFirstName(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text(
                                  'Error: ${snapshot.error}',
                                  style: TextStyle(color: Colors.red),
                                );
                              } else {
                                return Text(
                                  'Hi ${snapshot.data}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                );
                              }
                            },
                          ),
                          Text(
                            "Welcome to our App",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
                        },
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.cyan[900],
                          ),
                          child: Icon(Icons.notifications, size: 36, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Waste Collectors",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                    const SizedBox(height: 7),
                                    Text(
                                      "Request for waste collection",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Icon(
                                    Icons.recycling,
                                    size: 60,
                                    color: Colors.cyan[700],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Services",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 13),
            Container(
              height: 245,
              child: ListView.builder(
                itemCount: (services.length / 2).ceil(),
                itemBuilder: (context, index) {
                  final int firstColumn = index * 2;
                  final int secondColumn = firstColumn + 1;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (firstColumn < services.length)
                          ServiceCard(
                            name: services[firstColumn]["name"],
                            image: services[firstColumn]["image"],
                          ),
                        if (secondColumn < services.length)
                          ServiceCard(
                            name: services[secondColumn]["name"],
                            image: services[secondColumn]["image"],
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 11),
            Container(
              height: 120,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: PageView(
                controller: _pageController,
                children: const [
                  WelcomeBanner(
                    title: "What We Deal With",
                    description: "Our Company is mainly concerned with waste collection and we collect different categories of waste such as Plastics wastes, Solid Wastes and Liquid wastes",
                    backgroundColor: Colors.green,
                  ),
                  WelcomeBanner(
                    title: "Site Visit Schedule",
                    description: "Service will to eligible customers will be provided three days per week which are Monday, Wednesday and Saturday from 9:00 AM to 5:00 PM.",
                    backgroundColor: Colors.teal,
                  ),
                  WelcomeBanner(
                    title: "Membership Fee Payment",
                    description: "For a customer to be eligible to our services he/she must pay the service fee. We have two payment categories such as monthly fee and emergence service fee",
                    backgroundColor: Colors.cyan,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}
