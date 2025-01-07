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
