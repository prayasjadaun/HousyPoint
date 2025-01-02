import 'package:flutter/material.dart';

class AuthScreenProvider with ChangeNotifier {
  String _phoneNumber = '';
  String _otp = '';
  bool _isLoading = false;

  String get phoneNumber => _phoneNumber;
  String get otp => _otp;
  bool get isLoading => _isLoading;

  void setPhoneNumber(String number) {
    _phoneNumber = number;
    notifyListeners();
  }

  void setOtp(String code) {
    _otp = code;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<bool> verifyPhoneNumber() async {
    setLoading(true);
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    setLoading(false);
    return true;
  }

  Future<bool> verifyOtp(String otp) async {
    setLoading(true);
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    setLoading(false);
    return true;
  }
}
