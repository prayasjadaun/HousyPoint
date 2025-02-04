import 'dart:math';

import 'package:flutter/material.dart';

class LandmarksWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background with concentric circles
        Positioned.fill(
          child: CustomPaint(
            painter: CircleBackgroundPainter(),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Title
            const SizedBox(height: 30),
            const Text(
              "LANDMARKS",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 2,
              width: 80,
              color: Colors.amber,
            ),
            SizedBox(
              height: 20,
            ),
            // Subtitle
            Text(
              "Find Comfort, Just Around the Corner!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            // Central Logo
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/m3m_crown.png',
                height: 50,
              ),
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
        // Circular Landmarks
        PositionedLandmarks(),
      ],
    );
  }
}

class CircleBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final center = Offset(size.width / 2, size.height / 2);
    final radii = [110.0, 140.0, 170.0];

    for (var radius in radii) {
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class PositionedLandmarks extends StatelessWidget {
  final List<Landmark> landmarks = [
    Landmark(name: "Hospital", km: '2 km', angle: 300),
    Landmark(name: "School", km: '100 m', angle: -20),
    Landmark(name: "Mall", km: '200 m', angle: 20),
    Landmark(name: "Park", km: '50 m', angle: 40),
    Landmark(name: "Gym", km: '2 km', angle: 200),
    Landmark(name: "Tennis Court", km: '1 km', angle: 130),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        return Stack(
          children: landmarks
              .map((landmark) => LandmarkIcon(landmark, size))
              .toList(),
        );
      },
    );
  }
}

class Landmark {
  final String name;
  final double angle;
  final String km;

  Landmark({required this.name, required this.angle, required this.km});
}

class LandmarkIcon extends StatelessWidget {
  final Landmark landmark;
  final Size parentSize;

  const LandmarkIcon(this.landmark, this.parentSize);

  @override
  Widget build(BuildContext context) {
    final radius = 150.0;
    final angleRadians = landmark.angle * (pi / 180);

    final dx = parentSize.width / 2 + radius * -sin(angleRadians) - 10;
    final dy = parentSize.height / 2 + radius * cos(angleRadians) - 15;

    return Positioned(
      left: dx,
      top: dy,
      child: Column(
        children: [
          Icon(Icons.location_on, size: 30, color: Colors.blue),
          Text(
            landmark.name,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          Text(
            landmark.km,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
