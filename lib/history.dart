import 'package:flutter/material.dart';
import 'package:haux_huntr/generate_qr_code.dart'; // Import your GenerateQRCode page
// import 'package:haux_huntr/scan_qr_code.dart'; // Import your ScanQRCode page

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // Dummy list of scanned QR codes (replace with your actual data)
    List<Map<String, dynamic>> scannedCodes = [
      {'code': 'https://itunes.com', 'date': '2024-04-15'},
      {'code': 'https://itunes.com', 'date': '2024-04-14'},
      // Add more entries as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Scan History'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Scan'),
            Tab(text: 'Create'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildScanTab(scannedCodes),
          GenerateQRCode(), // Your GenerateQRCode page
        ],
      ),
    );
  }

  Widget _buildScanTab(List<Map<String, dynamic>> scannedCodes) {
    return ListView.builder(
      itemCount: scannedCodes.length,
      itemBuilder: (context, index) {
        final code = scannedCodes[index]['code'];
        final date = scannedCodes[index]['date'];

        return Card(
          elevation: 2,

          child: ListTile(
            leading: Icon(Icons.qr_code, color: Colors.teal), // Teal QR code icon
            title: Text(code),
            subtitle: Row(
              children: [
                Text(date), // Moved date to be below the delete icon
                Spacer(), // Add space between date and delete icon
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.teal), // Teal delete icon
                  onPressed: () {
                    // Implement code to delete the record
                    // You may want to show a confirmation dialog before deleting
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
