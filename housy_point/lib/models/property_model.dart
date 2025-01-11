import 'package:flutter/material.dart';

class Property {
  final String imageUrl;
  final String title;
  final String location;
  final double bhk; // Represents the number of bedrooms (e.g., 3.5 BHK)
  final int reviews; // Total number of reviews for the property
  final int price; // Price of the property in thousands (e.g., 500 = $500k)
  final String? description;
  final List<String>? amenities;
  final Icon? icon;

  Property({
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.bhk,
    required this.reviews,
    required this.price,
    this.description,
    this.amenities,
    this.icon,
  });
}
final List<Property> properties = [
    Property(
      imageUrl: 'assets/images/property.jpg',
      title: 'Cozy Apartment',
      location: 'New York, USA',
      bhk: 4.5,
      reviews: 120,
      price: 200,
      description:
          'A cozy and affordable apartment in the heart of New York City.',
      amenities: ['Gym', 'Parking', 'Laundry'],
    ),
    Property(
      imageUrl: 'assets/images/property.jpg',
      title: 'Luxury Villa',
      location: 'Los Angeles, USA',
      bhk: 3.5,
      reviews: 95,
      price: 500,
      description: 'A luxurious villa with a modern design and stunning views.',
      amenities: ['Swimming Pool', 'Home Theater', 'Garden'],
    ),
    Property(
      imageUrl: 'assets/images/property.jpg',
      title: 'Modern Condo',
      location: 'Chicago, USA',
      bhk: 4,
      reviews: 75,
      price: 150,
      description: 'A sleek modern condo in downtown Chicago.',
      amenities: ['Rooftop Deck', 'Fitness Center', '24/7 Security'],
    ),
    Property(
      imageUrl: 'assets/images/property.jpg',
      title: 'Beachfront House',
      location: 'Miami, USA',
      bhk: 4,
      reviews: 180,
      price: 700,
      description: 'A beautiful beachfront property with stunning ocean views.',
      amenities: ['Private Beach Access', 'Swimming Pool', 'Outdoor Kitchen'],
    ),
    Property(
      imageUrl: 'assets/images/property.jpg',
      title: 'Mountain Cabin',
      location: 'Aspen, USA',
      bhk: 4.5,
      reviews: 60,
      price: 250,
      description:
          'A peaceful cabin surrounded by the scenic mountains of Aspen.',
      amenities: ['Fireplace', 'Hiking Trails', 'Hot Tub'],
    ),
    Property(
      imageUrl: 'assets/images/property.jpg',
      title: 'Rustic Cottage',
      location: 'Vermont, USA',
      bhk: 4,
      reviews: 40,
      price: 180,
      description:
          'A charming rustic cottage nestled in Vermont’s countryside.',
      amenities: ['Wood Stove', 'Garden', 'Barn'],
    ),
    Property(
      imageUrl: 'assets/images/property.jpg',
      title: 'Penthouse Suite',
      location: 'San Francisco, USA',
      bhk: 5,
      reviews: 200,
      price: 800,
      description: 'A luxurious penthouse suite with breathtaking city views.',
      amenities: ['Rooftop Pool', 'Private Elevator', 'Smart Home Features'],
    ),
    Property(
      imageUrl: 'assets/images/property.jpg',
      title: 'Historic Home',
      location: 'Boston, USA',
      bhk: 5,
      reviews: 110,
      price: 300,
      description:
          'A charming historic home with a blend of vintage and modern.',
      amenities: ['Library', 'Wine Cellar', 'Patio'],
    ),
    Property(
      imageUrl: 'assets/images/property.jpg',
      title: 'Farmhouse Retreat',
      location: 'Nashville, USA',
      bhk: 3,
      reviews: 85,
      price: 220,
      description: 'A peaceful farmhouse retreat perfect for relaxation.',
      amenities: ['Porch Swing', 'Farm Animals', 'Open Fields'],
    ),
    Property(
      imageUrl: 'assets/images/property.jpg',
      title: 'Urban Loft',
      location: 'Seattle, USA',
      bhk: 4,
      reviews: 130,
      price: 350,
      description:
          'A stylish urban loft with stunning views of Seattle’s skyline.',
      amenities: ['Industrial Design', 'High Ceilings', 'Skylights'],
    ),
  ];