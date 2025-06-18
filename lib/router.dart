import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok2/features/auth/birthday_screen.dart';
import 'package:tiktok2/features/auth/email_screen.dart';
import 'package:tiktok2/features/auth/login_screen.dart';
import 'package:tiktok2/features/auth/sign_up_screen.dart';
import 'package:tiktok2/features/auth/username_screen.dart';
import 'package:tiktok2/features/main_navigation/main_navigation_screen.dart';
import 'package:tiktok2/features/onboarding/interests_screen.dart';
import 'package:tiktok2/features/onboarding/tutorial_screen.dart';
import 'package:tiktok2/features/video/video_recording_screen.dart';

final router = GoRouter(
  initialLocation: "/main",
  routes: [
    GoRoute(path: "/", builder: (context, state) => const SignUpScreen()),
    GoRoute(
      path: "/login",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: LoginScreen(),
          transitionDuration: Duration(milliseconds: 800),
          reverseTransitionDuration: Duration(milliseconds: 800),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation);
            return SlideTransition(
              position: offsetAnimation,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
        );
      },
    ),
    GoRoute(
      path: "/username",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: UsernameScreen(),
          transitionDuration: Duration(milliseconds: 1000),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    ),
    GoRoute(
      path: "/email",
      builder: (context, state) {
        final extra = state.extra as EmailScreenArgs;
        return EamilScreen(args: extra);
      },
    ),
    GoRoute(
      path: "/birthday",
      builder: (context, state) => const BirthdayScreen(),
    ),
    GoRoute(
      path: "/interests",
      builder: (context, state) => const InterestsScreen(),
    ),
    GoRoute(
      path: "/onboarding",
      builder: (context, state) => const TutorialScreen(),
    ),
    GoRoute(
      path: "/main",
      builder: (context, state) {
        return MainNavigationScreen();
      },
    ),
    GoRoute(
      path: "/main/username/:username",
      builder: (context, state) {
        return MainNavigationScreen(tab: 4);
      },
    ),
    GoRoute(
      path: "/video/recording",
      builder: (context, state) => const VideoRecordingScreen(),
    ),
  ],
);
