import 'package:flutter/material.dart';

class Distress {
  final String imageUrl;
  final String title;
  final String location;
  final double bhk; // Represents the number of bedrooms (e.g., 3.5 BHK)
  final int reviews; // Total number of reviews for the Distress
  final double price; // Price of the Distress in thousands (e.g., 500 = $500k)
  final String? description;
  final List<String>? amenities;
  final Icon? icon;

  Distress({
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

final List<Distress> properties = [
  Distress(
    imageUrl: 'assets/images/property.jpg',
    title: 'Cozy Apartment',
    location: 'New York, USA',
    bhk: 4.5,
    reviews: 120,
    price: 20.0,
    description:
        'A cozy and affordable apartment in the heart of New York City.',
    amenities: ['Gym', 'Parking', 'Laundry'],
  ),
  Distress(
    imageUrl: 'assets/images/propertyone.jpeg',
    title: 'Luxury Villa',
    location: 'Los Angeles, USA',
    bhk: 3.5,
    reviews: 95,
    price: 50.0,
    description: 'A luxurious villa with a modern design and stunning views.',
    amenities: ['Swimming Pool', 'Home Theater', 'Garden'],
  ),
  Distress(
    imageUrl: 'assets/images/propertytwo.jpg',
    title: 'Modern Condo',
    location: 'Chicago, USA',
    bhk: 4,
    reviews: 75,
    price: 15.0,
    description: 'A sleek modern condo in downtown Chicago.',
    amenities: ['Rooftop Deck', 'Fitness Center', '24/7 Security'],
  ),
  Distress(
    imageUrl: 'assets/images/propertythree.jpg',
    title: 'Beachfront House',
    location: 'Miami, USA',
    bhk: 4,
    reviews: 180,
    price: 70.0,
    description: 'A beautiful beachfront Distress with stunning ocean views.',
    amenities: ['Private Beach Access', 'Swimming Pool', 'Outdoor Kitchen'],
  ),
  Distress(
    imageUrl: 'assets/images/propertyfour.jpg',
    title: 'Mountain Cabin',
    location: 'Aspen, USA',
    bhk: 4.5,
    reviews: 60,
    price: 2.50,
    description:
        'A peaceful cabin surrounded by the scenic mountains of Aspen.',
    amenities: ['Fireplace', 'Hiking Trails', 'Hot Tub'],
  ),
  Distress(
    imageUrl: 'assets/images/propertyfive.jpg',
    title: 'Rustic Cottage',
    location: 'Vermont, USA',
    bhk: 4,
    reviews: 40,
    price: 1.80,
    description: 'A charming rustic cottage nestled in Vermont’s countryside.',
    amenities: ['Wood Stove', 'Garden', 'Barn'],
  ),
  Distress(
    imageUrl: 'assets/images/property.jpg',
    title: 'Penthouse Suite',
    location: 'San Francisco, USA',
    bhk: 5,
    reviews: 200,
    price: 8.00,
    description: 'A luxurious penthouse suite with breathtaking city views.',
    amenities: ['Rooftop Pool', 'Private Elevator', 'Smart Home Features'],
  ),
  Distress(
    imageUrl: 'assets/images/propertyone.jpeg',
    title: 'Historic Home',
    location: 'Boston, USA',
    bhk: 5,
    reviews: 110,
    price: 3.00,
    description: 'A charming historic home with a blend of vintage and modern.',
    amenities: ['Library', 'Wine Cellar', 'Patio'],
  ),
  Distress(
    imageUrl: 'assets/images/propertytwo.jpg',
    title: 'Farmhouse Retreat',
    location: 'Nashville, USA',
    bhk: 3,
    reviews: 85,
    price: 2.20,
    description: 'A peaceful farmhouse retreat perfect for relaxation.',
    amenities: ['Porch Swing', 'Farm Animals', 'Open Fields'],
  ),
  Distress(
    imageUrl: 'assets/images/propertythree.jpg',
    title: 'Urban Loft',
    location: 'Seattle, USA',
    bhk: 4,
    reviews: 130,
    price: 3.50,
    description:
        'A stylish urban loft with stunning views of Seattle’s skyline.',
    amenities: ['Industrial Design', 'High Ceilings', 'Skylights'],
  ),
];
