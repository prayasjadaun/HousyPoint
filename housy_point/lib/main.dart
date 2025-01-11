import 'package:flutter/material.dart';
import 'package:housy_point/providers/auth_screen_provider.dart';
import 'package:housy_point/providers/bottom_step_manager_provider.dart';
import 'package:housy_point/providers/onbording_provider.dart';
import 'package:housy_point/providers/registration_provider.dart';
import 'package:housy_point/providers/shortlisted_provider.dart';
import 'package:housy_point/providers/splash_screen_provider.dart';
import 'package:housy_point/providers/theme_provider.dart';
import 'package:housy_point/views/screens/home_screen.dart';
import 'package:housy_point/views/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'providers/home_screen_provider.dart';
import 'providers/menu_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashScreenProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => ShortlistProvider()),
        ChangeNotifierProvider(
            create: (context) => BottomStepManagerProvider()),
        ChangeNotifierProvider(create: (_) => OnBoardingProvider()),
        ChangeNotifierProvider(create: (_) => AuthScreenProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => RegistrationProvider()),
        ChangeNotifierProvider(create: (context) => HomeScreenProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Housy Point',
      theme: ThemeData.light(useMaterial3: true).copyWith(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.grey.shade200,
        iconTheme: IconThemeData(color: Colors.green.shade900),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black87),
        ),
      ),
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: Colors.black,
        cardColor: Colors.grey.shade800,
        iconTheme: IconThemeData(color: Colors.tealAccent),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      themeMode: ThemeMode.system, // Automatically uses system theme
      home: SplashScreen(),
    );
  }
}
