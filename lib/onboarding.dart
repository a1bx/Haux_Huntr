import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: OnboardingScreen(),
  ));
}

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/img.png', // Replace with your image asset path
                height: 200,
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to Haux Hunter',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Scan QR codes to know if your product is legit or a haux.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Text('Get Started'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Haux Huntr'),
      ),
      body: Center(
        child: Text('Haux Huntr'),
      ),
    );
  }
}
