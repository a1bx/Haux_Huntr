import 'package:flutter/material.dart';
import 'package:haux_huntr/generate_qr_code.dart';
import 'package:haux_huntr/scan_qr_code.dart';
import 'package:haux_huntr/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haux Huntr',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Qr code scanner',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(

        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/qr_scan.png',
                height: 150,
                width: 150,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ScanQRCode()),
                    );
                  });
                },
                child: Text(
                    'Scan Qr code',
                  style: TextStyle(
                    color: Colors.teal,
                  ),
                ),

              ),
              SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => GenerateQRCode()),
                    );
                  });
                },
                child: Text(
                    'Generate QR Code',
                  style: TextStyle(
                    // fontSize: 20.0,
                    // fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('History'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Log out'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
