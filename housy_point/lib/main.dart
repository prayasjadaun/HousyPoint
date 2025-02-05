import 'package:flutter/material.dart';
import 'package:housy_point/controllers/providers/authProvider/auth_screen_provider.dart';
import 'package:housy_point/controllers/providers/bottomNavProvider/bottom_step_manager_provider.dart';
import 'package:housy_point/controllers/providers/propertiesProvider/distress_deal_provider.dart';
import 'package:housy_point/controllers/providers/splashProvider/onbording_provider.dart';
import 'package:housy_point/controllers/providers/propertiesProvider/property_slider_provider.dart';
import 'package:housy_point/controllers/providers/authProvider/registration_provider.dart';
import 'package:housy_point/controllers/providers/bottomNavProvider/shortlisted_provider.dart';
import 'package:housy_point/controllers/providers/splashProvider/splash_screen_provider.dart';
import 'package:housy_point/controllers/providers/themeProvider/theme_provider.dart';
import 'package:housy_point/splash_screen.dart';
import 'controllers/providers/homeProvider/home_screen_provider.dart';
import 'controllers/providers/menuProvider/menu_provider.dart';
import 'package:provider/provider.dart';
// import 'views/screens/bottomNavBarScreens/home_screen.dart';
import 'views/screens/homeLoanScreen/home_loan_screen.dart';

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
        ChangeNotifierProvider(create: (context) => DistressDealProvider()),
        ChangeNotifierProvider(
          create: (_) => PropertySliderProvider(),
        ),
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
        themeMode: ThemeMode.system,
        home: 
        HomeLoanScreen()
        // HomeScreen(),
        // SplashScreen(),
        );
  }
}
