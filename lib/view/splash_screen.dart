import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart'; // replace with your actual home screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  double _scale = 0.0;

  @override
  void initState() {
    super.initState();

    // Start zoom animation after build
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() => _scale = 1.0);
    });

    // Navigate to Home after delay
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutBack,
          child: Container(
            width: size.width * 0.5,
            height: size.width * 0.5,
            // decoration: BoxDecoration(
            //   color: Theme.of(context).colorScheme.primary,
            //   shape: BoxShape.circle,
            // ),
            child: Center(
              child: Hero(
                  tag: 'logo',
                  child: Image.asset('assets/images/logo.png', ))
            ),
          ),
        ),
      ),
    );
  }
}
