import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultPage extends StatefulWidget {
  final String qrResult;
  final String scanDate;
  final bool isGenuine;

  const ResultPage({Key? key, required this.qrResult, required this.scanDate, required this.isGenuine}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool showQRCode = false;

  void copyURL() {
    if (widget.qrResult.startsWith('http') || widget.qrResult.startsWith('https')) {
      Clipboard.setData(ClipboardData(text: widget.qrResult));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('URL copied to clipboard')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No URL to copy')),
      );
    }
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> launchInApp(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  void launchURLInBrowser() {
    if (widget.qrResult.startsWith('http') || widget.qrResult.startsWith('https')) {
      Uri uri = Uri.parse(widget.qrResult);
      launchInBrowser(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No valid URL to launch')),
      );
    }
  }

  void launchURLInApp() {
    if (widget.qrResult.startsWith('http') || widget.qrResult.startsWith('https')) {
      Uri uri = Uri.parse(widget.qrResult);
      launchInApp(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No valid URL to launch')),
      );
    }
  }

  void scanQR() {
    Navigator.pop(context); // Go back to the ScanQRCode page
  }

  void showHistory() {
    Navigator.pop(context); // Go back to the ScanQRCode page, then show history
    // To properly show the history, you should ensure that the ScanQRCode page handles showing the history when returned from ResultPage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QR Code Result',
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
      body: buildResult(),
    );
  }

  Widget buildResult() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                      'Scanned Data',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    Text(
                      widget.scanDate,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            SelectableText(
              widget.qrResult,
              style: TextStyle(fontSize: 18, color: Colors.teal),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              widget.isGenuine ? 'The product is genuine.' : 'The product is not genuine.',
              style: TextStyle(
                fontSize: 18,
                color: widget.isGenuine ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                setState(() {
                  showQRCode = !showQRCode;
                });
              },
              child: Text(
                'Show QR Code',
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
            ),
            if (showQRCode)
              Center(
                child: QrImageView(
                  data: widget.qrResult,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: copyURL,
                    icon: Icon(Icons.copy, color: Colors.teal),
                    label: Text(
                      'Copy URL',
                      style: TextStyle(color: Colors.teal, fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: launchURLInBrowser,
                    icon: Icon(Icons.open_in_browser, color: Colors.teal),
                    label: Text(
                      'Launch in browser',
                      style: TextStyle(color: Colors.teal, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: launchURLInApp,
                icon: Icon(Icons.app_shortcut_outlined, color: Colors.teal),
                label: Text(
                  'Launch in app',
                  style: TextStyle(color: Colors.teal, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
