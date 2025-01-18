import 'package:flutter/material.dart';
import 'dart:async';

class AmenitiesScreen extends StatefulWidget {
  @override
  _AmenitiesScreenState createState() => _AmenitiesScreenState();
}

class _AmenitiesScreenState extends State<AmenitiesScreen> {
  final List<Amenity> amenities = [
    Amenity(name: "Basketball", icon: Icons.sports_basketball),
    Amenity(name: "Themed Garden", icon: Icons.park),
    Amenity(name: "Golf Putting", icon: Icons.golf_course),
    Amenity(name: "Swimming Pool", icon: Icons.pool),
    Amenity(name: "Gym", icon: Icons.fitness_center),
    Amenity(name: "Kids Play Area", icon: Icons.child_friendly),
    Amenity(name: "Tennis Court", icon: Icons.sports_tennis),
  ];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      // Reduced interval for faster updates
      if (_scrollController.hasClients) {
        double offset =
            _scrollController.offset + 5; // Increased offset increment
        if (offset >= _getMaxScrollExtent()) {
          offset = 0;
        }
        // Change the scroll position
        _scrollController.animateTo(
          offset,
          duration: Duration(milliseconds: 100),
          curve: Curves.linear,
        );
      }
    });
  }

  double _getMaxScrollExtent() {
    double totalWidth = amenities.length * 150.0;
    return totalWidth.toDouble();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        height: 100,
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: amenities.length * 2,
          itemBuilder: (context, index) {
            index = index % amenities.length;
            return AmenityCard(amenity: amenities[index]);
          },
        ),
      ),
    );
  }
}

class Amenity {
  final String name;
  final IconData icon;
  final image;

  Amenity({required this.name, required this.icon, this.image});
}

class AmenityCard extends StatelessWidget {
  final Amenity amenity;

  const AmenityCard({Key? key, required this.amenity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35,
            child: Icon(
              amenity.icon,
              color: Colors.blue.shade800,
              size: 20,
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: Text(
              amenity.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
                letterSpacing: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
