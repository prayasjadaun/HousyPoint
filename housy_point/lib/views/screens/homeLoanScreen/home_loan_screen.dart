import 'dart:async';
import 'package:flutter/material.dart';

class HomeLoanScreen extends StatefulWidget {
  const HomeLoanScreen({super.key});

  @override
  State<HomeLoanScreen> createState() => _HomeLoanScreenState();
}

class _HomeLoanScreenState extends State<HomeLoanScreen> with TickerProviderStateMixin {
  int _currentIndex = 0; // current index for top carousel
  int currentIndex = 0; // current index for page view
  final List<String> imagePath = [
    'assets/images/propertyone.jpeg',
    'assets/images/propertytwo.jpg',
    'assets/images/propertythree.jpg',
    'assets/images/propertyfour.jpg',
    'assets/images/propertyfive.jpg',
  ];

  late Timer _timer;
  bool _isExpanded = false; // Controls the animation state

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % imagePath.length; // Cycle through images
        _isExpanded = false; // Reset animation state
      });

      // Trigger animation after a short delay
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          setState(() {
            _isExpanded = true; // Enable animation
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
            // Fade-In Carousel View --------------
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 250, // Fixed height for the container
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 1000), // Fade duration
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: Stack(
                  key: ValueKey<String>(imagePath[_currentIndex]), // Unique key for each image
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imagePath[_currentIndex]),
                          fit: BoxFit.cover,
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
                        child: Column(
                          children: [
                            Text(
                              "Animated Text",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Animated Text",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Animated Text",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
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
              ),
            ),

            const SizedBox(height: 10),
            // Credit Card ------------------
            Container(
              height: 200,
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.all(10), // Add margin for spacing
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
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
                controller: PageController(initialPage: 0, viewportFraction: 0.9),
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.all(10), // Add margin for spacing
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey,
                    ),
                    child: Image.asset(
                      imagePath[index],
                      fit: BoxFit.cover, // Ensure the image covers the container
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
            // Types of banks-----------------------
            Column(
              children: [
                for (int i = 0; i < imagePath.length; i++)
                  BanksCustomContainer(imagePath: imagePath[i]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BanksCustomContainer extends StatelessWidget {
  const BanksCustomContainer({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(10), // Add margin for spacing
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey,
      ),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover, // Ensure the image covers the container
      ),
    );
  }
}