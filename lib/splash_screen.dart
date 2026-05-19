import 'package:flutter/material.dart';
import 'dart:async';
import 'option.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoAnimation;

  late AnimationController _textController;
  late Animation<double> _textAnimation;

  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    // Logo Fade In
    _logoController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
    );
    _logoController.forward();

    // Text Fade In
    _textController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeIn),
    );
    _textController.forward();

    // CircularProgress Scale Animation
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _progressAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );

    // Navigate to OptionPage after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OptionPage()),
      );
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _logoAnimation,
              child: Image.asset(
                "assets/image.png",
                height: 120,
              ),
            ),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: _textAnimation,
              child: const Text(
                "Hospital appointment system",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
            ScaleTransition(
              scale: _progressAnimation,
              child: const CircularProgressIndicator(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
