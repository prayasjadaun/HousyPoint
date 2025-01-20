import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:housy_point/controllers/providers/auth_screen_provider.dart';
import 'package:housy_point/views/auth/registration_screen.dart';
import 'package:housy_point/views/widgets/const/app_logo.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.onNext, required this.onBack});
  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  // Controllers for OTP fields
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  // Focus nodes for OTP fields
  final List<FocusNode> _focusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );

  // Timer-related variables
  late Timer _timer;
  int _start = 30; // Initial countdown duration (30 seconds)

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _start = 30; // Reset timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    // Dispose controllers, focus nodes, and timer
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppLogo(
              logoPath: 'assets/applogos/logo.png',
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'OTP Verification',
                style: GoogleFonts.merriweather(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 20),
            Consumer<AuthScreenProvider>(
              builder: (context, auth, _) => Center(
                child: Text(
                  "We've sent a verification code to\n${auth.phoneNumber}",
                  style: GoogleFonts.merriweather(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // OTP Input
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                (index) => Flexible(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: GoogleFonts.merriweather(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          if (index < 3) {
                            _focusNodes[index + 1].requestFocus();
                          } else {
                            _focusNodes[index].unfocus();
                          }
                        } else if (value.isEmpty && index > 0) {
                          _focusNodes[index - 1].requestFocus();
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Resend OTP Timer
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _start == 0
                    ? GestureDetector(
                        onTap: () {
                          // Logic to resend OTP
                          _startTimer();
                        },
                        child: Text(
                          'Resend OTP',
                          style: GoogleFonts.merriweather(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Text(
                        'Resend OTP in $_start s',
                        style: GoogleFonts.merriweather(
                          color: Colors.blue,
                        ),
                      ),
              ],
            ),
            const SizedBox(height: 50),
            // Login Button with SpinKit
            Consumer<AuthScreenProvider>(
              builder: (context, auth, _) => GestureDetector(
                onTap: auth.isLoading
                    ? null
                    : () async {
                        // ignore: unused_local_variable
                        final otp = _otpControllers
                            .map((controller) => controller.text)
                            .join();

                        if (await auth.verifyPhoneNumber()) {
                          auth.verifyPhoneNumber().then((success) {
                            if (success) {
                              Navigator.pop(context);
                              showRegistrationBottomSheet(context);
                            }
                          });
                        }
                      },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF004253),
                        Color(0xFF004240),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  alignment: Alignment.center,
                  child: auth.isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SpinKitThreeBounce(
                              color: Colors.white,
                              size: 24.0,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Verifying...',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          'Verify & Proceed',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showRegistrationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(1.0),
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Upper line or drag indicator
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  width: 10.0,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: RegistrationScreen(
                    onBack: () {},
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
