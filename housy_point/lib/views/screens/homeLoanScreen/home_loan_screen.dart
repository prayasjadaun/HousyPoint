import 'dart:async';

import 'package:flutter/material.dart';

class HomeLoanScreen extends StatefulWidget {
  const HomeLoanScreen({super.key});

  @override
  State<HomeLoanScreen> createState() => _HomeLoanScreenState();
}

class _HomeLoanScreenState extends State<HomeLoanScreen>
    with TickerProviderStateMixin {
  int currentIndex = 0;
  final List<String> imagePath = [
    'assets/images/propertyone.jpeg',
    'assets/images/propertytwo.jpg',
    'assets/images/propertythree.jpg',
    'assets/images/propertyfour.jpg',
    'assets/images/propertyfive.jpg',
  ];
  
  
  int _currentIndex = 0;
  bool _isExpanded = false;
  late Timer _timer; // Timer for automatic sliding

  @override
  void initState() {
    super.initState();
    // Start automatic sliding
    _startTimer();
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex < imagePath.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0; // Reset to the first page
      }
      if (mounted) {
        setState(() {
          _isExpanded = false; // Reset animation
        });
      }
      // Trigger animation after a short delay
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          setState(() {
            _isExpanded = true;
          });
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF004240),
        title: Image.asset(
          'assets/applogos/logo.png',
          height: 80,
          width: 160,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carousel View --------------
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 250, // Fixed height for the PageView
              child: PageView.builder(
                padEnds: false,
                pageSnapping: false,
                itemCount: imagePath.length,
                physics: const BouncingScrollPhysics(),
                controller: PageController(initialPage: _currentIndex),
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                    _isExpanded = false; // Reset animation on page change
                  });
                  // Trigger animation after a short delay
                  Future.delayed(const Duration(milliseconds: 300), () {
                    setState(() {
                      _isExpanded = true;
                    });
                  });
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded; // Toggle animation on tap
                      });
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          // Remove the image and replace it with a background color or gradient
                          child: Center(
                            child: Text(
                              "Page ${index + 1}",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        // Animated Text (Left to Right)
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          left: _isExpanded ? 20 : -MediaQuery.of(context).size.width,
                          top: 20,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: _isExpanded ? 1 : 0,
                            child: const Text(
                              "Animated Text",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        // Animated Icon (Right to Left)
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          right: _isExpanded ? 20 : -MediaQuery.of(context).size.width,
                          bottom: 20,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: _isExpanded ? 1 : 0,
                            child: const Icon(
                              Icons.star,
                              size: 40,
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),
            // Credit Card ------------------
            Container(
              height: 200,
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.all(10), // Add margin for spacing
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 10),
            // Trending Loans and offers -------------------
            SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              height: 200, // Fixed height for the PageView
              child: PageView.builder(
                padEnds: false,
                pageSnapping: false,
                itemCount: imagePath.length,
                controller:
                    PageController(initialPage: 0, viewportFraction: 0.9),
                onPageChanged: (value) {
                  currentIndex = value;
                  setState(() {});
                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.all(10), // Add margin for spacing
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Colors.grey,
                    ),
                    child: Image.asset(
                      imagePath[index],
                      fit:
                          BoxFit.cover, // Ensure the image covers the container
                    ),
                  );
                },
              ),
            ),
            TabPageSelector(
              controller: TabController(
                initialIndex: currentIndex,
                length: imagePath.length,
                vsync: this,
              ),
              selectedColor: Colors.black,
              borderStyle: BorderStyle.none,
              color: Colors.grey.shade300,
            ),
            // types of banks-----------------------
            
            Column(children: [
              for(int i =0; i< imagePath.length; i++)
                BanksCustomContainer(imagePath: imagePath[i],),
              
            ],)
          ],
        ),
      ),
    );
  }
}

class BanksCustomContainer extends StatelessWidget {
  const BanksCustomContainer({super.key, required this.imagePath});
  final String imagePath;
  // final Color color =[];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(10), // Add margin for spacing
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.grey,
      ),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover, // Ensure the image covers the container
      ),
    );
  }
}

