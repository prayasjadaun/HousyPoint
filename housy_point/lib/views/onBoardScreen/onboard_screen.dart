import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:housy_point/providers/onbording_provider.dart';
import 'package:housy_point/views/auth/auth_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _introKey = GlobalKey<IntroductionScreenState>();
  Timer? _timer;
  int _currentPage = 0;
  final int _numPages = 3;

  @override
  void initState() {
    super.initState();
    // Start timer for auto-sliding
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_currentPage < _numPages - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _introKey.currentState?.animateScroll(_currentPage);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnBoardingProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Image(
            image: AssetImage(
              'assets/applogos/logo.png',
            ),
            width: 200,
            height: 80,
          ),
        ),
        body: Consumer<OnBoardingProvider>(
          builder: (context, provider, _) => Column(
            children: [
              Expanded(
                child: IntroductionScreen(
                  key: _introKey,
                  pages: [
                    // First Page
                    PageViewModel(
                      titleWidget: const SizedBox.shrink(),
                      bodyWidget: buildPageContent(
                        context,
                        "2 Rooms Apartment",
                        "Gurugram, Haryana",
                        "assets/images/propertyone.jpeg",
                        0,
                      ),
                      decoration: getPageDecoration(),
                    ),
                    // Second Page
                    PageViewModel(
                      titleWidget: const SizedBox.shrink(),
                      bodyWidget: buildPageContent(
                        context,
                        "Luxury Villa",
                        "Delhi Phase 6, India",
                        "assets/images/propertytwo.jpg",
                        1,
                      ),
                      decoration: getPageDecoration(),
                    ),
                    // Third Page
                    PageViewModel(
                      titleWidget: const SizedBox.shrink(),
                      bodyWidget: buildPageContent(
                        context,
                        "Premium Penthouse",
                        "Sports ville, Mumbai",
                        "assets/images/property.jpg",
                        2,
                      ),
                      decoration: getPageDecoration(),
                    ),
                  ],
                  onChange: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                    provider.setCurrentPage(index);
                  },
                  onDone: () {},
                  showDoneButton: false,
                  showSkipButton: false,
                  showNextButton: false,
                  dotsDecorator: getDotDecoration(),
                  globalBackgroundColor: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    _timer?.cancel();
                    // Show the AuthScreen as a bottom sheet
                    showAuthBottomSheet(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                  ),
                  child: Text(
                    "Get Started",
                    style: GoogleFonts.merriweather(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

  Widget buildPageContent(BuildContext context, String title, String bodyText,
      String imagePath, int index) {
    return Column(
      children: [
        buildImage(context, imagePath, index),
        const SizedBox(height: 20),
        Text(
          title,
          style: GoogleFonts.merriweather(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          bodyText,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget buildImage(BuildContext context, String path, int index) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    Provider.of<OnBoardingProvider>(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height * (isPortrait ? 0.6 : 0.4),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            path,
            width: double.infinity,
            fit: BoxFit.cover,
          )),
    );
  }

  PageDecoration getPageDecoration() {
    return const PageDecoration(
      pageMargin: EdgeInsets.symmetric(horizontal: 10),
      titlePadding: EdgeInsets.zero,
      imagePadding: EdgeInsets.zero,
      pageColor: Colors.white,
    );
  }

  DotsDecorator getDotDecoration() {
    return DotsDecorator(
      color: Colors.grey,
      activeColor: Colors.black,
      size: const Size(10, 10),
      activeSize: const Size(22, 10),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }

  // Function to show the AuthScreen as a Bottom Sheet
  void showAuthBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor:
          Colors.transparent, // Makes the bottom sheet background transparent
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(
              16.0), // Adds padding inside the bottom sheet
          height: MediaQuery.of(context).size.height *
              0.7, // Adjusts height dynamically
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: const AuthScreen(), // Reuse your AuthScreen widget
        );
      },
    );
  }
}
