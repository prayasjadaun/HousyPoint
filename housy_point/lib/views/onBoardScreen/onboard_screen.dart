import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:housy_point/providers/onbording_provider.dart';
import 'package:housy_point/views/auth/auth_screen.dart';
import 'package:housy_point/views/auth/sequentiol_bottomsheet.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key, required this.onBack});

  final VoidCallback onBack;
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
    _startAutoScroll();
  }

  void _startAutoScroll() {
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
          title: const Image(
            image: AssetImage('assets/applogos/logo.png'),
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
                  pages: _getPages(context),
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
                    Navigator.pop(context); // Exit onboarding
                    showAuthBottomSheet(context); // Show bottom sheet
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

  List<PageViewModel> _getPages(BuildContext context) {
    return [
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
    ];
  }

  Widget buildPageContent(BuildContext context, String title, String bodyText,
      String imagePath, int index) {
    return Column(
      children: [
        buildImage(context, imagePath),
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

  Widget buildImage(BuildContext context, String path) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return SizedBox(
      height: MediaQuery.of(context).size.height * (isPortrait ? 0.6 : 0.4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          path,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
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

  void showAuthBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height * 0.7,
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
          child: AuthScreen(
            onNext: () {},
          ),
        );
      },
    );
  }

  void showSequentialBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height * 0.7,
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
          child: const SequentialBottomSheet(),
        );
      },
    );
  }
}
