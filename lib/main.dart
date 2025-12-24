import 'package:flutter/material.dart';
import 'theme.dart';
import 'splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LMS Hybrid App',
      theme: buildAppTheme(), // Terapkan tema dari lib/theme.dart
      home: const SplashScreen(), // SplashScreen baru
      debugShowCheckedModeBanner: false,
    );
  }
}
