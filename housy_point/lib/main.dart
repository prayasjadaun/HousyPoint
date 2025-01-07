import 'package:flutter/material.dart';
import 'package:housy_point/providers/auth_screen_provider.dart';
import 'package:housy_point/providers/onbording_provider.dart';
import 'package:housy_point/views/onBoardScreen/onboard_screen.dart';
import 'package:housy_point/views/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'providers/home_screen_provider.dart';
import 'providers/menu_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => OnBoardingProvider(),
        ),
        ChangeNotifierProvider(create: (_) => AuthScreenProvider()),
        ChangeNotifierProvider(create: (context) => HomeScreenProvider()),
        // ChangeNotifierProvider(create: (_) => PropertyFiltersProvider()),
        // ChangeNotifierProvider(create: (_) => PropertyFiltersProvider()),
        ChangeNotifierProvider(create: (context) => MenuProvider()),
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
      home: const HomeScreen(),
      // home: OnBoardingScreen(
      //   onBack: () {},
      // ),
    );
  }
}
