import 'package:flutter/material.dart';

// Model class for registration data
class RegistrationModel extends ChangeNotifier {
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _password = '';
  bool _agreedToTerms = false;

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  String get password => _password;
  bool get agreedToTerms => _agreedToTerms;

  void updateFirstName(String value) {
    _firstName = value;
    notifyListeners();
  }

  void updateLastName(String value) {
    _lastName = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    _password = value;
    notifyListeners();
  }

  void updateAgreedToTerms(bool value) {
    _agreedToTerms = value;
    notifyListeners();
  }
}
