import 'dart:async';

import 'package:flutter/material.dart';
import 'package:housy_point/models/property_model.dart';
import 'package:housy_point/views/widgets/property_card.dart';

class PropertyListScreen extends StatefulWidget {
  const PropertyListScreen({super.key, required selectedCategory});

  @override
  State<PropertyListScreen> createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;

  final List<Property> properties = [
    Property(
      imageUrl: 'assets/images/property.jpg',
      title: 'Cozy Apartment',
      location: 'New York, USA',
      rating: 4.5,
      reviews: 120,
      price: 200,
    ),
    Property(
      imageUrl: 'assets/images/property.jpg',
      title: 'Luxury Villa',
      location: 'Los Angeles, USA',
      rating: 4.8,
      reviews: 95,
      price: 500,
    ),
    Property(
      imageUrl: 'assets/images/property.jpg',
      title: 'Modern Condo',
      location: 'Chicago, USA',
      rating: 4.3,
      reviews: 75,
      price: 150,
    ),
    Property(
      imageUrl: 'assets/images/property.jpg',
      title: 'Beachfront House',
      location: 'Miami, USA',
      rating: 4.9,
      reviews: 180,
      price: 700,
    ),
    Property(
      imageUrl: 'assets/images/property.jpg',
      title: 'Mountain Cabin',
      location: 'Aspen, USA',
      rating: 4.7,
      reviews: 60,
      price: 250,
    ),
    Property(
      imageUrl: 'assets/images/property.jpg',
      title: 'Rustic Cottage',
      location: 'Vermont, USA',
      rating: 4.6,
      reviews: 40,
      price: 180,
    ),
    Property(
      imageUrl: 'assets/images/property.jpg',
      title: 'Penthouse Suite',
      location: 'San Francisco, USA',
      rating: 4.9,
      reviews: 200,
      price: 800,
    ),
    Property(
      imageUrl: 'assets/images/property.jpg',
      title: 'Historic Home',
      location: 'Boston, USA',
      rating: 4.4,
      reviews: 110,
      price: 300,
    ),
    Property(
      imageUrl: 'assets/images/property.jpg',
      title: 'Farmhouse Retreat',
      location: 'Nashville, USA',
      rating: 4.8,
      reviews: 85,
      price: 220,
    ),
    Property(
      imageUrl: 'assets/images/property.jpg',
      title: 'Urban Loft',
      location: 'Seattle, USA',
      rating: 4.5,
      reviews: 130,
      price: 350,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _stopAutoScroll();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      _currentPage = (_currentPage + 1) % properties.length;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      );
    });
  }

  void _stopAutoScroll() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Available Properties",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 250,
            child: GestureDetector(
              onPanDown: (_) => _stopAutoScroll(),
              onPanCancel: () => _startAutoScroll(),
              onPanEnd: (_) => _startAutoScroll(),
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemCount: properties.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: PropertyCard(property: properties[index]),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              properties.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade300,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
