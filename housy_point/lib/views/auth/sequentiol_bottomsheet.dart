import 'package:flutter/material.dart';
import 'package:housy_point/views/auth/auth_screen.dart';
import 'package:housy_point/views/auth/otp_screen.dart';
import 'package:housy_point/views/auth/registration_screen.dart';

class SequentialBottomSheet extends StatefulWidget {
  const SequentialBottomSheet({super.key});

  @override
  State<SequentialBottomSheet> createState() => _SequentialBottomSheetState();
}

class _SequentialBottomSheetState extends State<SequentialBottomSheet> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
        _pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          AuthScreen(onNext: _nextStep),
          OtpScreen(onNext: _nextStep, onBack: _previousStep),
          RegistrationScreen(onBack: _previousStep),
        ],
      ),
    );
  }
}
