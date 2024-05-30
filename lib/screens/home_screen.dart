import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haux_huntr/screens/generate_qr_code.dart';
import 'package:haux_huntr/screens/scan_qr_code.dart';
import 'package:haux_huntr/screens/history.dart';
import 'package:haux_huntr/screens/settings.dart'; // Import the Settings screen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> scannedQRCodes = []; // List to store scanned QR codes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Haux Huntr',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('History'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRHistoryPage(scanHistory: scannedQRCodes)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SvgPicture.asset(
            //   'assets/images/blockchain.svg',
            //   height: 100,
            // ),
            SizedBox(height: 20),
            Text(
              'Welcome to Haux Huntr!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Use this app to verify the authenticity of products using blockchain technology. Scan or generate QR codes to get started.',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 40),
            Column(
              children: [
                Image.asset('assets/images/img.png',
                  height: 170,
                ),
              ],
            ),
            SizedBox(height: 40),
            ExpansionTile(
              title: Text('Scanned QR Codes History'),
              initiallyExpanded: false,
              children: scannedQRCodes.isNotEmpty
                  ? scannedQRCodes.map((code) => ListTile(title: Text(code))).toList()
                  : [Text('No scanned QR codes yet')],
              onExpansionChanged: (expanded) {
                if (expanded) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QRHistoryPage(scanHistory: scannedQRCodes)),
                  );
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.qr_code_scanner),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GenerateQRCode()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.history),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRHistoryPage(scanHistory: scannedQRCodes)),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ScanQRCode()),
          );
        },
        child: Icon(Icons.qr_code,
        color: Colors.teal,
        ),
      ),
    );
  }
}
