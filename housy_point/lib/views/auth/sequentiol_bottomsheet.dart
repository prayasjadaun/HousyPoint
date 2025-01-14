import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import the provider package
import 'package:housy_point/views/auth/auth_screen.dart';
import 'package:housy_point/views/auth/otp_screen.dart';
import 'package:housy_point/views/auth/registration_screen.dart';
import '../../controllers/providers/bottom_step_manager_provider.dart';

class SequentialBottomSheet extends StatelessWidget {
  const SequentialBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          BottomStepManagerProvider(), // Provide the StepManager instance
      child: Consumer<BottomStepManagerProvider>(
        builder: (context, stepManager, child) {
          final PageController _pageController = PageController(
            initialPage: stepManager.currentStep,
          );

          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                AuthScreen(onNext: () {
                  stepManager.nextStep();
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                }),
                OtpScreen(
                  onNext: () {
                    stepManager.nextStep();
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                  onBack: () {
                    stepManager.previousStep();
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                ),
                RegistrationScreen(
                  onBack: () {
                    stepManager.previousStep();
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
