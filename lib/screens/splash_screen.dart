// splash_screen.dart
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:haux_huntr/screens/onboarding-screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 5000,
      splash: Column(
        children: [
          // Image.asset('assets/images/blue_logo.png'),
          Text(
            'Haux Huntr',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.teal
            ),
          ),
        ],
      ),
      nextScreen: OnboardingScreen(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}