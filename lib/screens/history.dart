import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  final List<String> scanHistory;

  const HistoryPage({Key? key, required this.scanHistory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan History'),
      ),
      body: ListView.builder(
        itemCount: scanHistory.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.qr_code),
            title: Text(scanHistory[index]),
          );
        },
      ),
    );
  }
}

class QRHistoryPage extends StatefulWidget {
  final List<String> scanHistory;

  const QRHistoryPage({Key? key, required this.scanHistory}) : super(key: key);
  @override
  _QRHistoryPageState createState() => _QRHistoryPageState();
}

class _QRHistoryPageState extends State<QRHistoryPage> {
  final List<String> scanHistory = [
    'https://itunes.com',
    'https://itunes.com',
    'https://itunes.com',
    'https://itunes.com',
    'https://itunes.com',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Scan',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Create',
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: scanHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.qr_code),
                  title: Text(scanHistory[index]),
                  subtitle: Text('16 Dec 2022, 9:30 pm'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        scanHistory.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.qr_code_scanner),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.history),
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.home),
      ),
    );
  }
}
