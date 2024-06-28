import 'package:flutter/material.dart';
import 'package:music_player/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   
  @override
  void initState() {
    super.initState();
   _delay();
  }

  

  Future<void> _delay() async {
  
      Future.delayed(const Duration(milliseconds: 100), () {

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      });
          
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff102042),
      body: Center(
        child: Image.asset("assets/images/splash.png"),
      ),
    );
  }
}
