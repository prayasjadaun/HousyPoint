import 'dart:async';
import 'package:flutter/material.dart';
import 'package:housy_point/views/screens/homeLoanScreen/loan_calculator.dart';
import 'package:housy_point/views/screens/homeLoanScreen/payment_breakdown.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math' as math;

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
    Colors.orange.shade50,
    Colors.blue.shade50,
    Colors.green.shade50,
  ];

  // Define loanCardColors as a list of colors
  final List<Color> loanCardColors = [
    Colors.blue.shade50,
    Colors.purple.shade50,
    Colors.orange.shade50,
    Colors.green.shade50,
  ];

  // Define loanCardText as a list of strings
  final List<String> loanCardText = [
    'Home Loan\nInstant approval at lowest interest rates\n8.35 %\nCheck Eligibility',
    'Loan Against Property\nLowest interest rate\n9.2 %\nCheck Eligibility',
    'Business Loan\nInterest rate starting from\n14 %\nCheck Eligibility',
    'Personal Loan\nPaperless process at low rate\n10.49 %\nCheck Eligibility',
  ];

  final List<Text> backgroundText = [
    Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Your dream\n",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          TextSpan(
            text: "Home with Simpler\n",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Color(0xFF004240),
            ),
          ),
          TextSpan(
            text: "Faster\n",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Colors.red.shade700,
            ),
          ),
          TextSpan(
            text: "Friendlier ",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Color(0xFF004240),
            ),
          ),
          TextSpan(
            text: "Home Loans\n",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Colors.red.shade700,
            ),
          ),
          TextSpan(
            text: "✅100% Paperless\n",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: "✅Lowest Interest Rate",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
    Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Get Your\n",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          TextSpan(
            text: "Personal Loan\n",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Colors.blue.shade900,
            ),
          ),
          TextSpan(
            text: "Loaded with Benefits\n",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Color(0xFF004240),
            ),
          ),
          TextSpan(
            text: "✅Attractive Interest Rates\n",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: "✅100% Paperless",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
    Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Get Instant\n",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Colors.grey.shade700,
            ),
          ),
          TextSpan(
            text: "L&T Finance\n",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Color(0xFF004240),
            ),
          ),
          TextSpan(
            text: "Personal Loan in\n",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Color(0xFF004240),
            ),
          ),
          TextSpan(
            text: "2 Minutes\n",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Color(0xFF004240),
            ),
          ),
          TextSpan(
            text: "✅Digital Process\n",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: "✅Instant Approval",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.black,
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

  @override
  Widget build(BuildContext context) {
    return _buildHomeLoan();
  }
  // _isLoading ? _buildShimmerEffect() :

  Widget _buildHomeLoan() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF004240),
        title: Image.asset(
          'assets/applogos/logo.png',
          height: 80,
          width: 180,
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
                duration: const Duration(milliseconds: 1000), // Fade duration
                transitionBuilder: (Widget child, Animation<double> animation) {
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
                        color: carouselBackgroundColors[
                            _currentIndex % carouselBackgroundColors.length],
                      ),
                    ),
                    // Animated Text (Left to Right)------------
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeInOut,
                      left:
                          _isExpanded ? 20 : -MediaQuery.of(context).size.width,
                      top: 20,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 700),
                        opacity: _isExpanded ? 1 : 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 10,
                              runSpacing: 20,
                              alignment: WrapAlignment.start,
                              children: [
                                backgroundText[
                                    _currentIndex % backgroundText.length],
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                  child: Text(
                                'Apply Now',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w700),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Animated Image (Right to Left)------------
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeInOut,
                      right:
                          _isExpanded ? 20 : -MediaQuery.of(context).size.width,
                      bottom: 20,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 700),
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
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              height: 250, // Increased height to avoid overflow
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     spreadRadius: 2,
                //     blurRadius: 5,
                //     offset: Offset(0, 3),
                //   ),
                // ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 10),
                  Center(
                    child: CustomGauge(
                      value:
                          0.7, // 0.0 to 1.0, where 0.0 is far left and 1.0 is far right
                      size: 100,
                      colors: const [
                        Colors.red,
                        Colors.orange,
                        Colors.yellow,
                        Colors.lightGreen,
                        Colors.green,
                      ],
                      strokeWidth: 25,
                      needleColor: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Use Align or Center to center the text
                  Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Get Your CIBIL Credit Report ",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: "worth 500\n",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                              color: Colors.yellow.shade900,
                            ),
                          ),
                          TextSpan(
                            text: "for FREE\n",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                              color: Colors.green.shade600,
                            ),
                          ),
                          TextSpan(
                            text:
                                '5 Lac + people have got their Credit Scores for FREE!',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center, // Center-align the text
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Check Your  ",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: "FREE  ",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 13,
                                color: Colors.green.shade900,
                              ),
                            ),
                            TextSpan(
                              text: "Credit Score",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: " →",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 13,
                                color: Colors.purple.shade900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Trending Loans and offers -------------------
            CustomTitleRow(title: 'Trending Loan Offers',),
            SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              height: 200,
              child: PageView.builder(
                  padEnds: false,
                  pageSnapping: false,
                  itemCount: loanCardText.length,
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: loanCardColors[index],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            loanCardText[index]
                                .split('\n')[0], // Loan type (e.g., Home Loan)
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            loanCardText[index].split('\n')[
                                1], // Description (e.g., Instant approval...)
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            loanCardText[index]
                                .split('\n')[2], // Interest rate (e.g., 8.35 %)
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Flexible(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Check Eligibility →',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            TabPageSelector(
              controller: TabController(
                initialIndex: currentIndex,
                length: loanCardText.length,
                vsync: this,
              ),
              selectedColor: Colors.black,
              borderStyle: BorderStyle.none,
              color: Colors.grey.shade300,
            ),
            // Types of banks---------------------------
            CustomTitleRow(title: 'Types of Bank',),
            Column(
              children: [
                BanksCustomContainer(
                  titleText: "NBFC\n",
                  contentText: 'Leading NBFCs\nHome Loan Rate: 8.75% - 11.50%\n'
                      'Non-Banking Financial Companies offering competitive home loan rates with flexible eligibility criteria and quick processing.',
                  buttonText: 'Read More',
                  iconImage: 'assets/loanImages/nbfcbank.png',
                ),
                BanksCustomContainer(
                  titleText: "PRIVATE BANKS\n",
                  contentText:
                      'Premium Private Banks\nHome Loan Rate: 8.50% - 10.75%\n'
                      'Leading private sector banks providing premium banking services with competitive home loan rates and personalized solutions.',
                  buttonText: 'Read More',
                  iconImage: 'assets/loanImages/privatebank.png',
                ),
                BanksCustomContainer(
                  titleText: "GOVERNMENT BANK\n",
                  contentText:
                      'Public Sector Banks\nHome Loan Rate: 8.40% - 9.75%\n'
                      'Government-backed banks offering reliable home loan services with competitive interest rates and maximum security.',
                  buttonText: 'Read More',
                  iconImage: "assets/loanImages/govtbank.png",
                ),
              ],
            ),
            // Loan Calculator-----------
            Container(height: 1000, child: LoanCalculator()),
            SizedBox(height: 10),
            // Payment Breakdown Widget-------
            Container(height: 800, child: EMIStructureScreen()),
          ],
        ),
      ),
    );
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
                  for (int i = 0; i < 3; i++)
                    Container(
                      height: 300,
                      clipBehavior: Clip.antiAlias,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                    ),
                  // Loan calculator Shimmer Effect-----------
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Placeholder for Pie Chart
                        Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.grey[800],
                        ),
                        const SizedBox(height: 24),
                        // Placeholder for Monthly EMI
                        Container(
                          height: 30,
                          width: 150,
                          color: Colors.grey[800],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 50,
                          width: 200,
                          color: Colors.grey[800],
                        ),
                        const SizedBox(height: 24),
                        // Placeholder for Breakdown
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 50,
                              width: 80,
                              color: Colors.grey[800],
                            ),
                            Container(
                              height: 50,
                              width: 80,
                              color: Colors.grey[800],
                            ),
                            Container(
                              height: 50,
                              width: 80,
                              color: Colors.grey[800],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BanksCustomContainer extends StatelessWidget {
  const BanksCustomContainer({
    required this.iconImage,
    required this.buttonText,
    required this.titleText,
    required this.contentText,
    super.key,
  });

  final String titleText;
  final String contentText;
  final String buttonText;
  final String iconImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(0),
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Heading Text------
          Positioned(
              left: 10,
              top: 20,
              child: Text(
                titleText,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 20),
              )),
          // Right Circle Container------
          Positioned(
            top: -40,
            right: -30,
            child: Container(
              height: 190,
              width: 190,
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(0.1)),
                  child: Image.asset(iconImage, fit: BoxFit.cover,),
            ),
          ),
          // Icon Container------
          Positioned(
            top: -80,
            right: -60,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 40),
              height: 200,
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                ],
              ),
            ),
          ),

          // Content Text Container--------
          Positioned(
            bottom: 50,
            right: 10,
            left: -1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Column(
                children: [
                  Text(
                    contentText,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 10,
            child: Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.black),
              child: Center(
                  child: Text(
                buttonText,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              )),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomGauge extends StatelessWidget {
  final double value; // Value between 0 and 1
  final double size;
  final List<Color> colors;
  final double strokeWidth;
  final Color backgroundColor;
  final Color needleColor;

  const CustomGauge({
    Key? key,
    required this.value,
    this.size = 200,
    this.colors = const [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.lightGreen,
      Colors.green,
    ],
    this.strokeWidth = 20,
    this.backgroundColor = Colors.blue,
    this.needleColor = Colors.black87,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size / 2,
      child: CustomPaint(
        painter: _GaugePainter(
          value: value,
          colors: colors,
          strokeWidth: strokeWidth,
          backgroundColor: backgroundColor,
          needleColor: needleColor,
        ),
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double value;
  final List<Color> colors;
  final double strokeWidth;
  final Color backgroundColor;
  final Color needleColor;

  _GaugePainter({
    required this.value,
    required this.colors,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.needleColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    // Paint for the background arc
    final bgPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Draw background arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      bgPaint,
    );

    // Calculate the number of segments
    final numSegments = colors.length;
    final segmentAngle = math.pi / numSegments;

    // Draw colored segments
    for (int i = 0; i < numSegments; i++) {
      final paint = Paint()
        ..color = colors[i]
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;

      final startAngle = math.pi + (i * segmentAngle);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        segmentAngle,
        false,
        paint,
      );
    }

    // Draw the needle
    final needleLength = radius - (strokeWidth / 2);
    final needleAngle = math.pi + (value * math.pi);
    final needleEndX = center.dx + needleLength * math.cos(needleAngle);
    final needleEndY = center.dy + needleLength * math.sin(needleAngle);

    final needlePath = Path()
      ..moveTo(center.dx - 4, center.dy) // Start slightly left of center
      ..lineTo(center.dx + 4, center.dy) // Move right to create base
      ..lineTo(needleEndX, needleEndY) // Draw to tip
      ..close(); // Close the path

    final needlePaint = Paint()
      ..color = needleColor
      ..style = PaintingStyle.fill;

    canvas.drawPath(needlePath, needlePaint);

    // Draw center point
    final centerPaint = Paint()
      ..color = needleColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, strokeWidth / 2, centerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

//  main content title widget
class CustomTitleRow extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry padding;
  final TextStyle textStyle;
  final MainAxisAlignment alignment;

  const CustomTitleRow({
    Key? key,
    required this.title,
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: 14,
      color: Colors.black,
    ),
    this.alignment = MainAxisAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: alignment,
        children: [
          Text(
            title,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
