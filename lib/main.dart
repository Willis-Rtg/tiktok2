import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok2/common/video_config/config.dart';
import 'package:tiktok2/features/auth/birthday_screen.dart';
import 'package:tiktok2/features/auth/email_screen.dart';
import 'package:tiktok2/features/auth/login_screen.dart';
import 'package:tiktok2/features/auth/sign_up_screen.dart';
import 'package:tiktok2/features/auth/username_screen.dart';
import 'package:tiktok2/features/onboarding/interests_screen.dart';
import 'package:tiktok2/features/onboarding/tutorial_screen.dart';
import 'package:tiktok2/features/video/repos/playback_config_repo.dart';
import 'package:tiktok2/features/video/vm/playback_config_vm.dart';
import 'package:tiktok2/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  FlutterError.onError = (FlutterErrorDetails details) {};

  final perferences = await SharedPreferences.getInstance();
  final repo = PlaybackConfigRepo(perferences);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlaybackConfigVm(repo)),
      ],
      child: const TiktokApp(),
    ),
  );
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
