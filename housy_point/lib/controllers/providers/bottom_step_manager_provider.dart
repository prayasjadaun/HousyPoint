import 'package:flutter/material.dart';

class BottomStepManagerProvider extends ChangeNotifier {
  int _currentStep = 0;

  int get currentStep => _currentStep;

  void nextStep() {
    if (_currentStep < 2) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }
}
