import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final String logoPath;
  final double padding;
  final double borderRadius;
  final List<Color> gradientColors;

  const AppLogo({
    super.key,
    required this.logoPath,
    this.padding = 10.0,
    this.borderRadius = 16.0,
    this.gradientColors = const [
      Color(0xFF004253),
      Color(0xFF004240),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 60,
        width: 250,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Image.asset(logoPath),
      ),
    );
  }
}
