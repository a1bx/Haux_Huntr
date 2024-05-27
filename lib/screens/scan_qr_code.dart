import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:haux_huntr/screens/history.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({Key? key}) : super(key: key);

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  String qrResult = '';
  bool qrScanned = false;
  bool showIcon = false;
  bool showQRCode = false;
  List<String> scanHistory = []; // List to store scan history

  Future<void> scanQR() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode('#008080', 'Cancel', true, ScanMode.QR);
      if (!mounted) return;
      setState(() {
        qrResult = qrCode;
        qrScanned = true; // Set to true after scanning
        showQRCode = false; // Reset QR code visibility
        scanHistory.add(qrCode); // Add to scan history
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
    if (await canLaunch(qrResult)) {
      await launch(qrResult);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cannot launch URL')),
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
          'Result',
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
      body: qrScanned ? buildResult() : buildScanButton(),
      bottomNavigationBar: qrScanned ? buildBottomNavigationBar() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: qrScanned
          ? FloatingActionButton(
        onPressed: scanQR,
        shape: CircleBorder(),
        child: Icon(Icons.qr_code),
      )
          : null,
    );
  }

  Widget buildResult() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.qr_code, color: Colors.teal, size: 50),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Data',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '16 Dec 2022, 9:30 pm',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            qrResult,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              setState(() {
                showQRCode = !showQRCode; // Toggle QR code visibility
              });
            },
            child: Text(
              'Show QR Code',
              style: TextStyle(color: Colors.blue, fontSize: 18),
            ),
          ),
          if (showQRCode)
            QrImageView(
              data: qrResult,
              version: QrVersions.auto,
              size: 200.0,
            ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                onPressed: copyURL,
                icon: Icon(Icons.copy),
                label: Text('Copy'),
              ),
              ElevatedButton.icon(
                onPressed: launchURL,
                icon: Icon(Icons.open_in_browser),
                label: Text('Launch'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildScanButton() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to the QR Code Scanner!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
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
          AnimatedSwitcher(
            duration: Duration(seconds: 1),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(child: child, scale: animation);
            },
            child: showIcon
                ? Icon(Icons.check_circle, color: Colors.teal, size: 100, key: UniqueKey())
                : ElevatedButton(
              key: UniqueKey(),
              onPressed: () {
                setState(() {
                  showIcon = !showIcon;
                });
                scanQR();
              },
              child: Text(
                'Scan Code',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
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
}

