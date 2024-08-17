import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'start_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Step 1: Set up the Animation Controller
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    // Step 2: Define the Scale Animation
    _scaleAnimation = Tween<double>(begin: 1.0, end: 2.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Step 3: Define the Opacity Animation
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Step 4: Reverse the animation to create a fade-out effect
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse(); // Start fade-out effect
      } else if (status == AnimationStatus.dismissed) {
        // Navigate to the StartScreen after the animation
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StartScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: FadeTransition(
          opacity: _opacityAnimation, // Apply fade animation
          child: ScaleTransition(
            scale: _scaleAnimation, // Apply zoom animation
            child: Text(
              'MalayMate',
              style: GoogleFonts.pacifico(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
