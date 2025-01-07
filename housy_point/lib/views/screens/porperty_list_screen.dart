import 'dart:async';
import 'package:flutter/material.dart';
import 'package:housy_point/models/apartment_listing_model.dart';
import 'package:housy_point/models/property_model.dart';
import 'package:housy_point/views/screens/apartment_listing_screen.dart';
import 'package:housy_point/views/widgets/utils/property_card.dart';

class PropertyListScreen extends StatefulWidget {
  final String selectedCategory;

  const PropertyListScreen({super.key, required this.selectedCategory});

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
          Text(
            "Available Properties in ${widget.selectedCategory}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 400,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ApartmentListingScreen(
                      apartmentListing: ApartmentListing(
                        property: properties[_currentPage],
                      ),
                    ),
                  ),
                );
              },
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
