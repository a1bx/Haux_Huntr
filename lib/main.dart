import 'package:flutter/material.dart';
// import 'package:haux_huntr/screens/scan_qr_code.dart';
import 'package:haux_huntr/screens/splash_screen.dart';
// import 'package:haux_huntr/web3dart/web3_service.dart';
// import 'qr_scanner.dart';
// import 'package:flutter_web3/flutter_web3.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Haux Huntr',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
