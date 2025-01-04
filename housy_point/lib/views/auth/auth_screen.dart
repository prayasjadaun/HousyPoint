// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:housy_point/providers/auth_screen_provider.dart';
import 'package:housy_point/views/auth/otp_screen.dart';
import 'package:housy_point/views/widgets/const/app_logo.dart';
import 'package:provider/provider.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
            child: Column(
              children: [
                AppLogo(
                  logoPath: 'assets/applogos/logo.png',
                ),
                const SizedBox(height: 40),
                Text(
                  "ONE STOP SOLUTION FOR ALL YOUR REAL ESTATE NEEDS",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Login via mobile number',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 30),
                Consumer<AuthScreenProvider>(
                  builder: (context, provider, _) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: provider.isPhoneValid
                            ? Colors.grey[300]!
                            : Colors.red, // Red border if validation fails
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode: true,
                              onSelect: (Country country) {
                                provider.setCountryCode(
                                  '+${country.phoneCode}',
                                  country.phoneCode
                                      .length, // Update expected length
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                provider.countryCode,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Enter Mobile Number',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              provider.setPhoneNumber(value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Consumer<AuthScreenProvider>(
                  builder: (context, auth, _) => GestureDetector(
                    onTap: () {
                      if (!auth.isLoading) {
                        auth.verifyPhoneNumber().then((success) {
                          if (success) {
                            Navigator.pop(context);
                            showOtpBottomSheet(context);
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
                              'Continue',
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
        ),
      ),
    );
  }

  void showOtpBottomSheet(BuildContext context) {
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
                  width: 80.0,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  height: MediaQuery.of(context).size.height * 0.7,
                 
                  child: OtpScreen(
                    onNext: () {},
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
