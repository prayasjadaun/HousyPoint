import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:housy_point/providers/auth_screen_provider.dart';
import 'package:housy_point/views/auth/otp_screen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Housy Point',
                    style: GoogleFonts.merriweather(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "ONE STOP SOLUTION FOR ALL YOUR REAL ESTATE NEEDS",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.merriweather(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Log in or sign up',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                // Phone Number Input
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IntlPhoneField(
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      context
                          .read<AuthScreenProvider>()
                          .setPhoneNumber(phone.completeNumber);
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Continue Button with SpinKit
                Consumer<AuthScreenProvider>(
                  builder: (context, auth, _) => ElevatedButton(
                    onPressed: auth.isLoading
                        ? null
                        : () async {
                            if (await auth.verifyPhoneNumber()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const OtpScreen(),
                                ),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: auth.isLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SpinKitThreeBounce(
                                color: Colors.black,
                                size: 24.0,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Verifying...',
                                style: GoogleFonts.merriweather(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            'Continue',
                            style: GoogleFonts.merriweather(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
