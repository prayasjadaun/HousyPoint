import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeLoanScreen extends StatefulWidget {
  const HomeLoanScreen({super.key});

  @override
  State<HomeLoanScreen> createState() => _HomeLoanScreenState();
}

class _HomeLoanScreenState extends State<HomeLoanScreen>
    with TickerProviderStateMixin {
  int _currentIndex = 0; // current index for top carousel
  int currentIndex = 0; // current index for page view
  final List<String> imagePath = [
    'assets/images/propertyone.jpeg',
    'assets/images/propertytwo.jpg',
    'assets/images/propertythree.jpg',
    'assets/images/propertyfour.jpg',
    'assets/images/propertyfive.jpg',
  ];

  final List<String> animateLoanImages = [
    'assets/loanImages/HomeLoan1.png',
    'assets/loanImages/HomeLoan2.png',
    'assets/loanImages/HomeLoan3.png',
  ];
  final List<Color> carouselBackgroundColors = [
    Colors.deepOrangeAccent.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
  ];

  final List<Text> backgroundText = [
    Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Your dream ",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          TextSpan(
            text: "Home with Simpler ",
            style: TextStyle(
              fontSize: 16,
              color: Colors.green.shade900,
            ),
          ),
          TextSpan(
            text: "Faster ",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          TextSpan(
            text: "Friendlier Home Loan ",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          TextSpan(
            text: "100% Paperless ",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          TextSpan(
            text: "Lowest Interest Rate",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
    Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Get Your ",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          TextSpan(
            text: "Personal Loan ",
            style: TextStyle(
              fontSize: 16,
              color: Colors.green.shade900,
            ),
          ),
          TextSpan(
            text: "Loaded with Benefits ",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          TextSpan(
            text: "Attractive Interest Rates ",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          TextSpan(
            text: "100% Paperless",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
    Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Get Instant ",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          TextSpan(
            text: "L&T Finance Personal Loan ",
            style: TextStyle(
              fontSize: 16,
              color: Colors.green.shade900,
            ),
          ),
          TextSpan(
            text: "in 2 Minutes ",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          TextSpan(
            text: "Digital Process ",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          TextSpan(
            text: "Instant Approval",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  ];

  late Timer _timer;
  bool _isExpanded = false; // Controls the animation state
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
    // Delay the shimmer effect by 2 seconds after the UI renders
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _currentIndex =
            (_currentIndex + 1) % imagePath.length; // Cycle through images
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

  Widget _buildShimmerEffect() {
    return SafeArea(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[50]!,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Appbar shimmer effect
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              // Carousel shimmer------
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              // Credit Card Shimmer effect----------
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              // Trending Loans and offers -------------------
              SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                height: 200, // Fixed height for the PageView
                child: PageView.builder(
                  padEnds: false,
                  pageSnapping: false,
                  itemCount: 10,
                  controller:
                      PageController(initialPage: 0, viewportFraction: 0.9),
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      clipBehavior: Clip.antiAlias,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
              TabPageSelector(
                controller: TabController(
                  initialIndex: currentIndex,
                  length: 10,
                  vsync: this,
                ),
                selectedColor: Colors.black,
                borderStyle: BorderStyle.none,
                color: Colors.grey.shade300,
              ),
              // Types of banks shimmer effect ------------
              Column(
                children: [
                  for (int i = 0; i < 5; i++)
                    Container(
                      height: 300,
                      clipBehavior: Clip.antiAlias,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? _buildShimmerEffect()
        : Scaffold(
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
                    height: 250,
                    child: AnimatedSwitcher(
                      duration:
                          const Duration(milliseconds: 1000), // Fade duration
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      child: Stack(
                        key: ValueKey<String>(imagePath[_currentIndex]),
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: carouselBackgroundColors[_currentIndex %
                                  carouselBackgroundColors.length],
                            ),
                          ),
                          // Animated Text (Left to Right)------------
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            left: _isExpanded
                                ? 20
                                : -MediaQuery.of(context).size.width,
                            top: 20,
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: _isExpanded ? 1 : 0,
                              child: // In the build method, replace the Column widget with:
                                  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  backgroundText[
                                      _currentIndex % backgroundText.length],
                                ],
                              ),
                            ),
                          ),
                          // Animated Image (Right to Left)------------
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            right: _isExpanded
                                ? 20
                                : -MediaQuery.of(context).size.width,
                            bottom: 20,
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: _isExpanded ? 1 : 0,
                              child: Image.asset(
                                animateLoanImages[
                                    _currentIndex % animateLoanImages.length],
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 220,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

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
                        setState(() {
                          currentIndex = value;
                        });
                      },
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          clipBehavior: Clip.antiAlias,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey,
                          ),
                          child: Image.asset(
                            imagePath[index],
                            fit: BoxFit.cover,
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
                  // Types of banks---------------------------
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

// Custom Container-------For banks cards--------
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
        fit: BoxFit.cover,
      ),
    );
  }
}
