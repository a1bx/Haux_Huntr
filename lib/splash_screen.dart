import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haux_huntr/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 3),(){
     Navigator.of(context).pushReplacement(MaterialPageRoute(
         builder: (_)=> const Homepage(),
     ));
    }
    );
  }
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors:[Colors.lightBlue,Colors.blueGrey],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const[
            Icon(
              Icons.qr_code,
            size: 80,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              'Haux Huntr',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white
              )
            )
          ],
        ),
      ),
    );
  }
}
