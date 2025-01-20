import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:housy_point/models/registrationModel/registration_field_model.dart';
import 'package:housy_point/views/screens/bottomNavBarScreens/home_screen.dart';
import 'package:housy_point/views/widgets/const/app_logo.dart';
import 'package:provider/provider.dart';

import '../../controllers/providers/registration_provider.dart';

class RegistrationScreen extends StatefulWidget {
  final VoidCallback onBack;

  const RegistrationScreen({super.key, required this.onBack});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RegistrationProvider>(context, listen: false);
      // Now you can safely access the provider
    });
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool agreedToTerms = false;
  bool isLoading = false; // To manage loading state

  @override
  Widget build(BuildContext context) {
    final registrationModel = Provider.of<RegistrationProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // App Logo
                    AppLogo(
                      logoPath: 'assets/applogos/logo.png',
                    ),
                    const SizedBox(height: 30),

                    // Title
                    const Text(
                      'Registration',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Fill the details below to sign up',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Name Field
                    RegistrationFieldModel(
                      label: 'Full Name',
                      icon: Icons.person_outline,
                      controller: _nameController,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter your full name'
                          : null,
                      onChanged: (value) =>
                          registrationModel.updateFirstName(value),
                    ),
                    const SizedBox(height: 20),

                    // Email Field
                    RegistrationFieldModel(
                      label: 'Email Address',
                      icon: Icons.email_outlined,
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }

                        final emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        );
                        if (!emailRegex.hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                      onChanged: (value) =>
                          registrationModel.updateEmail(value),
                    ),

                    const SizedBox(height: 20),

                    // Terms and Conditions
                    Row(
                      children: [
                        Transform.scale(
                          scale: 1.2,
                          child: Checkbox(
                            value: registrationModel.agreedToTerms,
                            onChanged: (bool? value) {
                              registrationModel
                                  .updateAgreedToTerms(value ?? false);
                            },
                            activeColor: Colors.black,
                            checkColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'I agree to the Terms and Conditions',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Sign Up Button
                    Center(
                      child: GestureDetector(
                        onTap: isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate() &&
                                    registrationModel.agreedToTerms) {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  // Simulate API call
                                  await Future.delayed(
                                      const Duration(seconds: 2));

                                  setState(() {
                                    isLoading = false;
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: const [
                                          Icon(Icons.check_circle,
                                              color: Colors.white, size: 24),
                                          SizedBox(width: 10),
                                          Text(
                                            'Registration Successful!',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: const Color(0xFF004240),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      duration: const Duration(seconds: 3),
                                    ),
                                  );

                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: const [
                                          Icon(Icons.error_outline,
                                              color: Colors.white, size: 24),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              'Please complete all fields correctly!',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.redAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      duration: const Duration(seconds: 3),
                                    ),
                                  );
                                }
                              },
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF004253), Color(0xFF004240)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: isLoading
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      SpinKitThreeBounce(
                                        color: Colors.white,
                                        size: 24.0,
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        'Verifying...',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  )
                                : const Text(
                                    'Sign up',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
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
        ),
      ),
    );
  }
}
