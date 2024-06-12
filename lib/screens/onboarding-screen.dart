import 'package:flutter/material.dart';
import 'package:haux_huntr/screens/home_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {
  final List<PageViewModel> pages = [
    PageViewModel(
      title: 'Welcome to Haux Huntr',
      body: 'Verify the authenticity of products using blockchain technology.',
      image: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/blue_logo.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
    PageViewModel(
      title: 'Scan Product QR Code',
      body: 'Simply scan the QR code on the product to verify its authenticity.',
      image: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/scan_qr.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
    PageViewModel(
      title: 'Secure and Transparent',
      body: 'Blockchain ensures transparency and security in product verification.',
      image: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/blue_logo.png'),
            fit: BoxFit.cover,
          ),
        ),
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
      skip: Text('Skip', style: TextStyle(color: Colors.lightBlue),),
      next: Icon(Icons.arrow_forward, color: Colors.lightBlue,),
      done: Text('Get Started',style: TextStyle(color: Colors.lightBlue),),
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.black,
        activeColor: Colors.blue,
      ),
    );
  }
}