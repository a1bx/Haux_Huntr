// // metamask_login.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_web3/flutter_web3.dart';
//
// class MetaMaskLogin {
//   static Future<bool> connect(BuildContext context) async {
//     if (ethereum == null) {
//       // MetaMask not installed
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('MetaMask Not Found'),
//             content: Text('Please install MetaMask to use this feature.'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//       return false;
//     } else {
//       // Request account access
//       try {
//         final accounts = await ethereum!.requestAccount();
//         if (accounts.isNotEmpty) {
//           // Successfully connected
//           return true;
//         }
//       } catch (e) {
//         // Handle error
//         print('Error connecting to MetaMask: $e');
//       }
//       return false;
//     }
//   }
// }
