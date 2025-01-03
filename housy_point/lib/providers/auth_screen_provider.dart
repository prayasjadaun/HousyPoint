import 'package:flutter/material.dart';

class AuthScreenProvider extends ChangeNotifier {
  String _countryCode = '+91'; // Default country code
  String _phoneNumber = ''; // User's phone number
  bool _isLoading = false; // Loading state for verification
  bool _isPhoneValid = true; // Phone number validation status

  // Getter for country code
  String get countryCode => _countryCode;

  // Getter for phone number
  String get phoneNumber => _phoneNumber;

  // Getter for loading status
  bool get isLoading => _isLoading;

  // Getter for phone validation status
  bool get isPhoneValid => _isPhoneValid;

  // Update country code
  void setCountryCode(String code) {
    _countryCode = code;
    notifyListeners();
  }

  // Update phone number
  void setPhoneNumber(String number) {
    _phoneNumber = number;
    _isPhoneValid = _validatePhoneNumber(number);
    notifyListeners();
  }

  // Validate phone number (basic validation, can be extended)
  bool _validatePhoneNumber(String number) {
    return number.isNotEmpty && number.length >= 6; // Adjust length as needed
  }

  // Trigger validation error
  void setValidationError() {
    _isPhoneValid = false;
    notifyListeners();
  }

  // Simulate phone number verification
  Future<bool> verifyPhoneNumber() async {
    if (_phoneNumber.isEmpty) {
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
