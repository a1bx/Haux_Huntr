// onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:haux_huntr/screens/home_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {
  final List<PageViewModel> pages = [
    PageViewModel(
      title: 'Welcome to Product ID Blockchain',
      body: 'Verify the authenticity of products using blockchain technology.',
      image: Center(
        child: Image.asset('assets/images/blue_logo.png'),
      ),
    ),
    PageViewModel(
      title: 'Scan Product QR Code',
      body: 'Simply scan the QR code on the product to verify its authenticity.',
      image: Center(
        child: Image.asset('assets/images/qr_scan.png'),
      ),
    ),
    PageViewModel(
      title: 'Secure and Transparent',
      body: 'Blockchain ensures transparency and security in product verification.',
      image: Center(
        child: Image.asset('assets/images/blue_logo.png'),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: pages,
      onDone: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      },
      showSkipButton: true,
      skip: Text('Skip'),
      next: Icon(Icons.arrow_forward),
      done: Text('Get Started'),
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.grey,
        activeColor: Colors.blue,
      ),
    );
  }
}