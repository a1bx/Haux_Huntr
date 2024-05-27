import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({Key? key}) : super(key: key);

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  String qrResult = 'Scanned Data will appear here';
  bool qrScanned = false;

  Future<void> scanQR() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode('#008080', 'Cancel', true, ScanMode.QR);
      if (!mounted) return;
      setState(() {
        qrResult = qrCode;
        qrScanned = true; // Set to true after scanning
      });
    } on PlatformException {
      setState(() {
        qrResult = 'Failed to read QR Code';
        qrScanned = false; // Set back to false if an error occurs
      });
    }
  }

  void copyURL() {
    if (qrResult.startsWith('http') || qrResult.startsWith('https')) {
      Clipboard.setData(ClipboardData(text: qrResult));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('URL copied to clipboard')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No URL to copy')),
      );
    }
  }

  void launchURL() async {
    if (await canLaunchUrl(qrResult as Uri)) {
      await launchUrl(qrResult as Uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cannot launch URL')),
      );
    }
  }

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/img.png',
              height: 150,
              width: 150,
            ),
            SizedBox(height: 80),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.qr_code, color: Colors.teal, size: 50), // QR code icon
                      SizedBox(width: 10),
                      Text(
                        'Scan Result',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 90),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      '$qrResult',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 70),
            ElevatedButton(
              onPressed: scanQR,
              child: Text(
                'Scan Code',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),
            SizedBox(height: 20),
            if (qrScanned) // Show only if a QR code has been scanned
              ElevatedButton(
                onPressed: copyURL,
                child: Text(
                  'Copy URL',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),
            SizedBox(height: 20),
            if (qrScanned) // Show only if a QR code has been scanned
              ElevatedButton(
                onPressed: launchURL,
                child: Text(
                  'Launch URL',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}