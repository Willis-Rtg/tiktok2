import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok2/features/auth/birthday_screen.dart';
import 'package:tiktok2/features/auth/email_screen.dart';
import 'package:tiktok2/features/auth/login_screen.dart';
import 'package:tiktok2/features/auth/sign_up_screen.dart';
import 'package:tiktok2/features/auth/username_screen.dart';
import 'package:tiktok2/features/onboarding/interests_screen.dart';
import 'package:tiktok2/features/onboarding/tutorial_screen.dart';
import 'package:tiktok2/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const TiktokApp());
}

class TiktokApp extends StatelessWidget {
  const TiktokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Tiktok',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: Typography.blackMountainView,
        brightness: Brightness.light,
        primaryColor: const Color(0xFFE9435A),
        // colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE9435A)),
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
      darkTheme: ThemeData(
        useMaterial3: true,
        textTheme: Typography.whiteMountainView,
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFE9435A),
        // colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE9435A)),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        // splashColor: Color(0xFFE9435A),
      ),
      routerConfig: router,
    );
  }
}
