import 'package:flutter/material.dart';

class MenuProvider extends ChangeNotifier {
  // Bottom Bar Index
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  String _currentLanguage = 'English';
  String _currentCountry = 'IN';
  String _currentCurrency = 'INR';

  String get language => _currentLanguage;
  String get country => _currentCountry;
  String get currency => _currentCurrency;

  String _userRole = 'Guest';  // Add a role property

  String get userRole => _userRole;  // Getter for userRole

  void updateLanguage(String newLanguage) {
    _currentLanguage = newLanguage;
    notifyListeners();
  }

  void updateCountry(String newCountry) {
    _currentCountry = newCountry;
    notifyListeners();
  }

  void updateCurrency(String newCurrency) {
    _currentCurrency = newCurrency;
    notifyListeners();
  }

  void updateIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  // Method to update user role
  void updateUserRole(String newRole) {
    _userRole = newRole;
    notifyListeners();
  }
}
