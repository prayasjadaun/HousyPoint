import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:housy_point/controllers/providers/auth_screen_provider.dart';
import 'package:housy_point/views/auth/otp_screen.dart';
import 'package:housy_point/views/widgets/const/app_logo.dart';
import 'package:provider/provider.dart';

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
                  "New to Housy Point? Let's start",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 30),
                Consumer<AuthScreenProvider>(
                  builder: (context, provider, child) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Phone Input Container
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: provider.isPhoneValid
                                    ? Colors.grey[300]!
                                    : Colors
                                        .red, // Red border if validation fails
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                // Country Code Selector
                                InkWell(
                                  onTap: () {
                                    showCountryPicker(
                                      context: context,
                                      showPhoneCode: true,
                                      onSelect: (Country country) {
                                        provider.setCountryCode(
                                            '+${country.phoneCode}');
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 16,
                                    ),
                                    child: Text(
                                      provider.countryCode,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                // Vertical Divider
                                Container(
                                  height: 30,
                                  width: 1,
                                  color: Colors.grey,
                                ),
                                // Phone Number Input
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: 'Enter phone number',
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 14,
                                      ),
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      PhoneNumberFormatter(
                                        provider.countryPhoneLengths[
                                                provider.countryCode] ??
                                            10,
                                      ),
                                    ],
                                    onChanged: (value) =>
                                        provider.setPhoneNumber(value, context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Continue Button
                          Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF004253),
                                    Color(0xFF004240),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12)),
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF004240),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: provider.isLoading
                                  ? null
                                  : () async {
                                      if (await provider.verifyPhoneNumber()) {
                                        showOtpBottomSheet(context);
                                      }
                                     
                                    },
                              child: provider.isLoading
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                  : const Text(
                                      'Continue',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
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
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  width: 20.0,
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

// Phone number formatter (if not already defined)
class PhoneNumberFormatter extends TextInputFormatter {
  final int maxLength;

  PhoneNumberFormatter(this.maxLength);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length > maxLength) {
      return TextEditingValue(
        text: newValue.text.substring(0, maxLength),
        selection: TextSelection.collapsed(offset: maxLength),
      );
    }
    return newValue;
  }
}
