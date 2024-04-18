import 'package:flutter/material.dart';
import 'package:haux_huntr/generate_qr_code.dart';
import 'package:haux_huntr/scan_qr_code.dart';
import 'package:haux_huntr/splash_screen.dart';
import 'package:haux_huntr/history.dart';

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
          'Haux Huntr',
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
              // SizedBox(height: 0),
              Image.asset(
                'assets/images/img.png',
                height: 150,
                width: 150,
              ),
              SizedBox(height: 80),
              SizedBox(height: 40),
              Text(
                'Pick any option to begin',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 80),
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
                color: Colors.teal[700],
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('History'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HistoryPage()),
                );
              },
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
