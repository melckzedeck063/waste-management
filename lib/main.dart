import 'package:flutter/material.dart';
import 'package:manage_waste/api/firebase_api.dart';
import 'package:manage_waste/pages/splash_screen.dart';
import 'package:manage_waste/provider/authentication_provider.dart';
import 'package:manage_waste/provider/booking_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final navigatorKey =  GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( name: "waste-manage", options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  runApp(
    ChangeNotifierProvider(
      create : (context) => AuthenticationProvider(),
      child : const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
          ChangeNotifierProvider(create: (_) => BookingProvider())
        ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

