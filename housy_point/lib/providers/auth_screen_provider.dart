import 'package:flutter/material.dart';

class AuthScreenProvider extends ChangeNotifier {
  String _countryCode = '+91'; // Default country code
  String _phoneNumber = ''; // User's phone number
  bool _isLoading = false; // Loading state for verification
  bool _isPhoneValid = true; // Phone number validation status
  int _expectedPhoneLength = 10; // Default expected length for India (+91)

  // Getter for country code
  String get countryCode => _countryCode;

  // Getter for phone number
  String get phoneNumber => _phoneNumber;

  // Getter for loading status
  bool get isLoading => _isLoading;

  // Getter for phone validation status
  bool get isPhoneValid => _isPhoneValid;

  // Update country code and set expected phone number length
  void setCountryCode(String code, int expectedLength) {
    _countryCode = code;
    _expectedPhoneLength = expectedLength;
    notifyListeners();
  }

  // Update phone number
  void setPhoneNumber(String number) {
    _phoneNumber = number;
    _isPhoneValid = _validatePhoneNumber(number);
    notifyListeners();
  }

  // Validate phone number based on the country code
  bool _validatePhoneNumber(String number) {
    // Check if the number length matches the expected length for the country
    return number.length == _expectedPhoneLength;
  }

  // Trigger validation error
  void setValidationError() {
    _isPhoneValid = false;
    notifyListeners();
  }

  // Simulate phone number verification
  Future<bool> verifyPhoneNumber() async {
    if (_phoneNumber.isEmpty || !_isPhoneValid) {
      setValidationError();
      return false;
    }

    _isLoading = true;
    notifyListeners();

    // Simulated verification delay
    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();

    return true;
  }
}
