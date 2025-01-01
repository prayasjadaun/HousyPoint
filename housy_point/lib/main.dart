import 'package:flutter/material.dart';
import 'package:housy_point/providers/property_filters_provider.dart';
import 'package:provider/provider.dart';
import 'views/screens/home_screen.dart';
import 'providers/home_screen_provider.dart';
import 'providers/menu_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeScreenProvider()),
        ChangeNotifierProvider(create: (_) => PropertyFiltersProvider()),
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
    );
  }
}
