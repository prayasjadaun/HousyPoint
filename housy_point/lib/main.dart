import 'package:flutter/material.dart';
import 'package:housy_point/providers/auth_screen_provider.dart';
import 'package:housy_point/providers/bottom_step_manager_provider.dart';
import 'package:housy_point/providers/onbording_provider.dart';
import 'package:housy_point/providers/registration_provider.dart';
import 'package:housy_point/providers/shortlisted_provider.dart';
import 'package:housy_point/providers/splash_screen_provider.dart';
import 'package:housy_point/views/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'providers/home_screen_provider.dart';
import 'providers/menu_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashScreenProvider()),
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
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen());
  }
}
