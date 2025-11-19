import 'package:flutter/material.dart';
import 'dart:async';
import 'package:talent_acquire/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start the timer
    Timer(const Duration(seconds: 3), () {
      _navigateToNextPage(); // Navigate after 3 seconds
    });
  }

  void _navigateToNextPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // Wrap with GestureDetector
      onTap: _navigateToNextPage, // Navigate on tap
      child: Scaffold(
        backgroundColor: Colors.green.shade500,
        body: Image.asset(
          'images/your_splash_image.png',
          fit: BoxFit.cover,
          width: double.infinity, // Full width
          height: double.infinity, // Full height
        ),
      ),
    );
  }
}