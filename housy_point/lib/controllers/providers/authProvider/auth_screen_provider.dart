import 'package:flutter/material.dart';

class AuthScreenProvider extends ChangeNotifier {
  String _countryCode = '+91';
  String _phoneNumber = '';
  bool _isLoading = false;
  bool _isPhoneValid = true;
  int _expectedPhoneLength = 10;
  bool _isAuthenticated = false;
  String _userRole = 'Guest';

  // Getters
  String get countryCode => _countryCode;
  String get phoneNumber => _phoneNumber;
  bool get isLoading => _isLoading;
  bool get isPhoneValid => _isPhoneValid;
  bool get isAuthenticated => _isAuthenticated;
  String get userRole => _userRole;
  
  final Map<String, int> countryPhoneLengths = {
    '+91': 10, // India
    '+1': 10,  // USA/Canada
    '+44': 10, // UK
    '+61': 9,  // Australia
    '+86': 11, // China
    '+81': 10, // Japan
    '+49': 11, // Germany
    '+33': 9,  // France
    '+7': 10,  // Russia
    '+55': 11, // Brazil
    
  };

  void setCountryCode(String code) {
    _countryCode = code;
    _expectedPhoneLength = countryPhoneLengths[code] ?? 10;
    // Don't reset phone number here to maintain better UX
    _isPhoneValid = _validatePhoneNumber(_phoneNumber);
    notifyListeners();
  }

  void setPhoneNumber(String number, BuildContext context) {
    String cleanNumber = number.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (cleanNumber.length > _expectedPhoneLength) {
      cleanNumber = cleanNumber.substring(0, _expectedPhoneLength);
    }
    
    _phoneNumber = cleanNumber;
    _isPhoneValid = _validatePhoneNumber(cleanNumber);
    notifyListeners();

    if (_isPhoneValid && cleanNumber.length == _expectedPhoneLength) {
      FocusScope.of(context).unfocus();
    }
  }

  bool _validatePhoneNumber(String number) {
    if (number.isEmpty) return true; // Don't show error for empty field
    return number.length == _expectedPhoneLength;
  }

  // Authentication methods
  void login(String username, String role) {
    _isAuthenticated = true;
    _userRole = role;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    _userRole = 'Guest';
    notifyListeners();
  }

  Future<bool> verifyPhoneNumber() async {
    if (_phoneNumber.isEmpty || !_isPhoneValid) {
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      // Add your phone verification logic here
      // For example, using Firebase Auth or your backend API
      await Future.delayed(const Duration(seconds: 2));
      return true;
    } catch (e) {
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String getFullPhoneNumber() {
    return '$_countryCode$_phoneNumber';
  }
}