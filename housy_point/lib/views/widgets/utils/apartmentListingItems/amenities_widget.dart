import 'package:flutter/material.dart';

class AmenitiesScreen extends StatelessWidget {
  final List<Amenity> amenities = [
    Amenity(name: "Basketball", icon: Icons.sports_basketball),
    Amenity(name: "Themed Garden", icon: Icons.park),
    Amenity(name: "Golf Putting", icon: Icons.golf_course),
    Amenity(name: "Swimming Pool", icon: Icons.pool),
    Amenity(name: "Gym", icon: Icons.fitness_center),
    Amenity(name: "Kids Play Area", icon: Icons.child_friendly),
    Amenity(name: "Tennis Court", icon: Icons.sports_tennis),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 180,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: amenities.length,
          itemBuilder: (context, index) {
            final amenity = amenities[index];
            return AmenityCard(amenity: amenity);
          },
        ),
      ),
    );
  }
}

class Amenity {
  final String name;
  final IconData icon;

  Amenity({required this.name, required this.icon});
}

class AmenityCard extends StatelessWidget {
  final Amenity amenity;

  const AmenityCard({Key? key, required this.amenity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey.shade200),
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 50,
            child: Icon(
              amenity.icon,
              color: Color(0xFF004240),
              size: 50,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            amenity.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              letterSpacing: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
