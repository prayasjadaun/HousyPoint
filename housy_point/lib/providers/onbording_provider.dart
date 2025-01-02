import 'package:flutter/material.dart';

class OnBoardingProvider with ChangeNotifier {
  final List<bool> _imageLoaded = [
    false,
    false,
    false
  ]; // Track loading status for each page.
  int _currentPage = 0; // Track the current page

  bool isImageLoaded(int index) => _imageLoaded[index];

  void setImageLoaded(int index) {
    if (!_imageLoaded[index]) {
      _imageLoaded[index] = true;
      notifyListeners();
    }
  }

  int get currentPage => _currentPage; // Getter for the current page

  void setCurrentPage(int index) {
    _currentPage = index;
    notifyListeners(); // Notify listeners when the current page changes
  }
}
