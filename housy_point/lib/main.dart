import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/screens/home_screen.dart';
import 'providers/home_screen_provider.dart'; // Import the provider
import 'providers/menu_provider.dart'; // Import another provider if needed

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeScreenProvider()),
        ChangeNotifierProvider(
            create: (context) => MenuProvider()), // Example of another provider
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
