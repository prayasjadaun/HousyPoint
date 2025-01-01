import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:housy_point/views/auth/auth_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Let us help you find the home of your dreams.",
            body:
                "Our agency is the industry's top luxury producer with over 27 years of experience.",
            image: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height *
                  0.5, // Half the screen height
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                image: DecorationImage(
                  image: AssetImage("assets/images/prop.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: "Best Offers",
            body:
                "Find the most suitable apartments and properties tailored to your needs.",
            image: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                image: DecorationImage(
                  image: AssetImage("assets/images/property.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: "Explore Details",
            body:
                "Get complete information about properties, including specifications, pricing, and availability.",
            image: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                image: DecorationImage(
                  image: AssetImage("assets/images/prop.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: getPageDecoration(),
          ),
        ],
        onDone: () => goToHome(context),
        showSkipButton: true,
        skip: const Text("Skip", style: TextStyle(color: Colors.black)),
        next: const Icon(Icons.arrow_forward, color: Colors.black),
        done: const Text("Get Started", style: TextStyle(color: Colors.black)),
        dotsDecorator: DotsDecorator(
          color: Colors.grey,
          activeColor: Colors.black,
          size: const Size(10.0, 10.0),
          activeSize: const Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }

  void goToHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const AuthScreen()),
    );
  }

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: GoogleFonts.merriweather(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodyTextStyle: GoogleFonts.merriweather(
          fontSize: 16.0,
          color: Colors.black54,
        ),
        imagePadding: EdgeInsets.zero,
        pageColor: Colors.white,
        contentMargin:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 150),
      );
}
