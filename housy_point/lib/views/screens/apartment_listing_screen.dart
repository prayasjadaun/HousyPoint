import 'dart:async';
import 'package:flutter/material.dart';
import 'package:housy_point/models/apartment_listing_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../models/apart_overview_grid_model.dart';

class ApartmentListingScreen extends StatefulWidget {
  const ApartmentListingScreen({super.key, required this.apartmentListing});
  final ApartmentListing apartmentListing;

  @override
  State<ApartmentListingScreen> createState() => _ApartmentListingScreenState();
}

class _ApartmentListingScreenState extends State<ApartmentListingScreen> {
  final List<String> imagePaths = [
    'assets/images/propertyone.jpeg',
    'assets/images/propertytwo.jpg',
    'assets/images/propertythree.jpg',
    'assets/images/propertyfour.jpg',
    'assets/images/propertyfive.jpg',
  ];

  late PageController _pageController;
  int _currentIndex = 0;
  String _backgroundImage = '';
  Timer? _autoBackgroundSlideTimer;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _backgroundImage = imagePaths[0];
    _startAutoSlide();
    _scrollController = ScrollController(); // Start the auto-slide timer
  }

  void _startAutoSlide() {
    _autoBackgroundSlideTimer =
        Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % imagePaths.length;
          _backgroundImage = imagePaths[_currentIndex];
        });
        _pageController.animateToPage(_currentIndex,
            duration: Duration(seconds: 5), curve: Curves.slowMiddle);
      }
    });
  }

  @override
  void dispose() {
    _autoBackgroundSlideTimer?.cancel();
    _scrollController.dispose(); // Clean up the controller when not in use
    _pageController.dispose();
    super.dispose();
  }

  void _onThumbnailTapped(int pageIndex) {
    if (_pageController.hasClients) {
      setState(() {
        _currentIndex = pageIndex; // Update current index
      });
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(seconds: 5),
        curve: Curves.linearToEaseOut,
      );
      _startAutoSlide(); // Restart auto-slide if necessary
    }
  }

  void _openImageViewer(BuildContext context) {
    PhotoViewGallery.builder(
      itemCount: imagePaths.length,
      pageController: PageController(initialPage: _currentIndex),
      builder: (context, index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: AssetImage(imagePaths[index]),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
          heroAttributes: PhotoViewHeroAttributes(tag: imagePaths[index]),
        );
      },
      scrollPhysics: BouncingScrollPhysics(),
      backgroundDecoration: BoxDecoration(color: Colors.black),
    );
  }

  void _openGridView(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: imagePaths.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                PhotoView(
                  imageProvider: AssetImage(imagePaths[index]),
                  backgroundDecoration: BoxDecoration(color: Colors.black),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2.0,
                );
              },
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    imagePaths[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: PageView(controller: _pageController, children: [
                Stack(
                  children: [
                    // Background Image
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(_backgroundImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Top Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child:
                                  Icon(Icons.arrow_back, color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.share, color: Colors.black),
                                ),
                                onPressed: () {
                                  // Add your onSharePressed logic
                                },
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.favorite_border,
                                      color: Colors.black),
                                ),
                                onPressed: () {
                                  // Add your onFavoritePressed logic
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Image Slider (Thumbnails and +10 Button)
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              // Thumbnails
                              for (int i = 0; i < imagePaths.length; i++)
                                GestureDetector(
                                  onTap: () {
                                    _onThumbnailTapped(i);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          border: _currentIndex == i
                                              ? Border.all(
                                                  color: Colors.blue,
                                                  width: 2.0)
                                              : null,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Image.asset(
                                          imagePaths[i],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(width: 8),
                              // +10 Button
                              GestureDetector(
                                onTap: () => _openGridView(context),
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[600],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '+10',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),

            // Type and Rating
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 25,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.grey[300]),
                        child: Center(
                          child: Text('Apartment',
                              style: TextStyle(
                                  color: Color(0xFF004240),
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '4.5 (365 reviews)',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Title
                  const Text(
                    'Woodland Apartments',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Address
                  Text(
                    widget.apartmentListing.distress.location,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Navigation Tabs
                  Row(
                    children: [
                      _buildTab('Overview', true),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Features Overview Screen
                  PremiumOverviewGridModel(),
                  const SizedBox(height: 24),
                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.apartmentListing.distress.description ??
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: widget.apartmentListing.onReadMorePressed,
                    child: const Text('Read more',
                        style: TextStyle(color: Color(0xFF004240))),
                  ),
                  const SizedBox(height: 16),
                  // Listing Agent
                  const Text(
                    'Listing Agent',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.grey[300],
                        child: const Icon(Icons.person),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Housy Point',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Price and Book Now
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 90,
        shape: CircularNotchedRectangle(),
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.transparent,
                blurRadius: 10,
                offset: Offset(0, -4),
              ),
            ],
            color: isDarkMode ? Colors.white : Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Total Price',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '\$1,500 /month',
                      style: TextStyle(
                        fontSize: 20,
                        color: isDarkMode ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              Container(
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: isDarkMode ? Colors.black : Colors.white,
                ),
                child: Center(
                  child: Text(
                    'Reserve Now',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTab(String text, bool isSelected) {
  return Container(
    margin: const EdgeInsets.only(right: 24),
    padding: const EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: isSelected ? Color(0xFF004240) : Colors.transparent,
          width: 2,
        ),
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: isSelected ? Color(0xFF004240) : Colors.grey[600],
        fontSize: 16,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    ),
  );
}

Widget _buildFeature(IconData icon, String text) {
  return Row(
    children: [
      Icon(icon, color: Color(0xFF004240), size: 24),
      const SizedBox(width: 8),
      Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
