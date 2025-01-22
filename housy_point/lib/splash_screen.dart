import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Import the package
import 'package:provider/provider.dart'; // Import the provider package
import 'controllers/providers/splash_screen_provider.dart';
import 'views/onBoardScreen/onboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the controller and animations
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Logo animation (scale)
    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Text animation (opacity and scale)
    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start animations
    _controller.forward();

    // After the splash duration, set splash state to finished
    Timer(const Duration(seconds: 3), () {
      // Use Provider to notify that splash has finished
      context.read<SplashScreenProvider>().finishSplash();

      // Navigate after the animation
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnBoardingScreen(onBack: () {}),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF004253), Color(0xFF004240)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo with scaling animation
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _logoAnimation.value,
                  child: child,
                );
              },
              child: Image.asset(
                'assets/applogos/small_logo.png',
                height: 120,
                width: 120,
              ),
            ),
            SizedBox(height: 20),
            // Text with opacity and scaling animation
            AnimatedOpacity(
              opacity: _textAnimation.value,
              duration: Duration(
                  seconds: 3), // Increased duration for better visibility
              child: Transform.scale(
                scale: _textAnimation.value,
                child: Text(
                  'Welcome to Housy Point',
                  style: GoogleFonts.poppins(
                    fontSize:
                        22, // Slightly larger font size for better visibility
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Using Flutter Spinkit for the loading indicator with a fade-in effect
            FadeTransition(
              opacity: _textAnimation,
              child: SpinKitFadingCircle(
                color: Colors.white,
                size: 40.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
