import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:manage_waste/pages/onboarding_pages.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Column(
          children: [
            Expanded(
                child: Center(
                  child: LottieBuilder.asset("lib/lotties/animate1.json"),
                )
            ),
            const Text("WASTE MANAGEMENT",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white
            ),
            )
          ],
        ),
        nextScreen: const OnBoardingScreen(),
      splashIconSize: 220,
      backgroundColor: Colors.cyan,
    );
  }
}
