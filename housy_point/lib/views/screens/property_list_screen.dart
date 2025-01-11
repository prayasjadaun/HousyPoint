import 'dart:async';
import 'package:flutter/material.dart';
import 'package:housy_point/models/apartment_listing_model.dart';
import 'package:housy_point/models/property_model.dart';
import 'package:housy_point/views/screens/apartment_listing_screen.dart';
import 'package:housy_point/views/widgets/utils/property_card.dart';

class PropertyListScreen extends StatefulWidget {
  // final String selectedCategory;

  const PropertyListScreen({
    super.key,
  });

  @override
  State<PropertyListScreen> createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen> {
  final PageController _pageController =
      PageController(viewportFraction: 0.8); // Use viewportFraction here
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll(); // Start auto-scroll after the first frame is rendered
    });
  }

  @override
  void dispose() {
    _stopAutoScroll();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        // Ensure the PageController is attached
        _currentPage = (_currentPage + 1) % properties.length;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _stopAutoScroll() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          SizedBox(
            height: 300,
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
                controller: _pageController, // Use the same controller here
                scrollDirection: Axis.horizontal,
                itemCount: properties.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: Transform.scale(
                      scale: _currentPage == index
                          ? 1.0
                          : 0.9, // Optional scaling effect
                      child: PropertyCard(property: properties[index]),
                    ),
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
                // margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 10,
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
