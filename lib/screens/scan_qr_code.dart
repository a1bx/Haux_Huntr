import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'result_page.dart';
import 'history.dart';
import 'package:intl/intl.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({Key? key}) : super(key: key);

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  List<String> scanHistory = []; // List to store scan history

  Future<void> scanQR() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode('#008080', 'Cancel', true, ScanMode.QR);
      if (!mounted) return;

      String scanDate = DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.now()); // Store the current date and time
      setState(() {
        scanHistory.add(qrCode); // Add to scan history
      });

      // Verify the QR code data
      bool isGenuine = isQRCodeGenuine(qrCode);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
            qrResult: qrCode,
            scanDate: scanDate,
            isGenuine: isGenuine,
          ),
        ),
      );
    } on PlatformException {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to read QR Code')),
      );
    }
  }

  void showHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRHistoryPage(scanHistory: scanHistory),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QR Code Scanner',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: buildScanButton(),
      bottomNavigationBar: buildBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: scanQR,
        shape: CircleBorder(),
        child: Icon(Icons.qr_code),
      ),
    );
  }

  Widget buildScanButton() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Authenticate your Product here!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          SizedBox(height: 40),
          Column(
            children: [
              Image.asset(
                'assets/images/img.png',
                height: 170,
              ),
            ],
          ),
          SizedBox(height: 50),
          Text(
            'Press the button below to start scanning:',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 20),
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
        ],
      ),
    );
  }

  BottomAppBar buildBottomNavigationBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: scanQR,
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: showHistory,
          ),
        ],
      ),
    );
  }

  bool isQRCodeGenuine(String scannedQRCode) {
    // Check if the scanned QR code contains a URL
    if (scannedQRCode.startsWith('http://') || scannedQRCode.startsWith('https://')) {
      return false; // Mark as fake if it contains a URL
    }
    return true; // Otherwise, mark as genuine
  }
}
