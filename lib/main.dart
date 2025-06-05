import 'package:flutter/material.dart';
import 'package:tiktok2/features/inbox/activity_screen.dart';
import 'package:tiktok2/features/main_navigation/main_navigation_screen.dart';

void main() {
  runApp(const TiktokApp());
}

class TiktokApp extends StatelessWidget {
  const TiktokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tiktok',
      theme: ThemeData(
        primaryColor: const Color(0xFFE9435A),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE9435A)),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        // splashColor: Color(0xFFE9435A),
      ),
      home: MainNavigationScreen(),
    );
  }
}
