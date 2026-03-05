import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Ensure this path matches your folder structure

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe App',
      theme: ThemeData(
        // Using the yellow/gold seed color which signifies food and warmth, fitting for a recipe app
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 200, 0),
        ),
        useMaterial3: true,
      ),
      // Points to your custom HomeScreen instead of the default counter
      home: const HomeScreen(),
    );
  }
}