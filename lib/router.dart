import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok2/features/auth/birthday_screen.dart';
import 'package:tiktok2/features/auth/email_screen.dart';
import 'package:tiktok2/features/auth/login_screen.dart';
import 'package:tiktok2/features/auth/password_screen.dart';
import 'package:tiktok2/features/auth/repos/auth_repo.dart';
import 'package:tiktok2/features/auth/sign_up_screen.dart';
import 'package:tiktok2/features/auth/username_screen.dart';
import 'package:tiktok2/features/chats/chat_detail_screen.dart';
import 'package:tiktok2/features/chats/chats_screen.dart';
import 'package:tiktok2/features/error_screen.dart';
import 'package:tiktok2/features/inbox/activity_screen.dart';
import 'package:tiktok2/features/main_navigation/main_navigation_screen.dart';
import 'package:tiktok2/features/onboarding/interests_screen.dart';
import 'package:tiktok2/features/onboarding/tutorial_screen.dart';
import 'package:tiktok2/features/user/settings_screen.dart';
import 'package:tiktok2/features/video/views/video_preview_screen.dart';
import 'package:tiktok2/features/video/views/video_recording_screen.dart';
import 'package:tiktok2/features/video/vm/timeline_vm.dart';

/// The main router for the application.
///
/// This defines the main routing table for the application. It includes
/// routes for the authentication flow, the main navigation tabs, and
/// various other features.
///
/// The authentication flow includes the following routes:
///
/// - `/auth`
/// - `/login`
/// - `/username`
/// - `/email`
/// - `/password`
/// - `/birthday`
///
/// The main navigation tabs include the following routes:
///
/// - `/:tab(home|discover|inbox|profile)`
///
/// The other features include the following routes:
///
/// - `/inbox/activity`
/// - `/inbox/chats`
/// - `/inbox/chats/:id`
/// - `/profile/:username/settings`
/// - `/video/recording`
/// - `/video/preview`
final routerProvider = Provider((ref) {
  // final change = ref.watch(authStateProvider);
  return GoRouter(
    initialLocation: "/home",
    // errorBuilder: (context, state) {
    //   print(state.error);
    //   return ErrorScreen(error: state.error!);
    // },
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepoProvider).isLoggedin;

      if (!isLoggedIn) {
        if (state.fullPath != "/auth/signup" &&
            state.fullPath != "/auth/login" &&
            state.fullPath != "/auth/username" &&
            state.fullPath != "/auth/email" &&
            state.fullPath != "/auth/password" &&
            state.fullPath != "/auth/birthday")
          return "/auth/signup";
      }
      return null;
    },
    routes: [
      GoRoute(path: "/", builder: (context, state) => const SignUpScreen()),
      GoRoute(
        path: "/auth",
        builder: (context, state) => const SignUpScreen(),
        routes: [
          GoRoute(
            path: "/login",
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                child: LoginScreen(),
                transitionDuration: Duration(milliseconds: 800),
                reverseTransitionDuration: Duration(milliseconds: 800),
                transitionsBuilder: (
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                ) {
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
            path: "/signup",
            builder: (context, state) => const SignUpScreen(),
          ),
          GoRoute(
            path: "/username",
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                child: UsernameScreen(),
                transitionDuration: Duration(milliseconds: 1000),
                transitionsBuilder: (
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                ) {
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
            path: "/password",
            builder: (context, state) => const PasswordScreen(),
          ),
          GoRoute(
            path: "/birthday",
            builder: (context, state) => const BirthdayScreen(),
          ),
        ],
      ),
      GoRoute(
        path: "/interests",
        builder: (context, state) => const InterestsScreen(),
      ),
      GoRoute(
        path: "/tutorial",
        builder: (context, state) => const TutorialScreen(),
      ),
      GoRoute(
        path: "/:tab(home|discover|inbox|profile)",
        pageBuilder: (context, state) {
          final tab = state.pathParameters["tab"]!;
          return CustomTransitionPage(
            child: MainNavigationScreen(tab: tab),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),
      GoRoute(
        path: "/inbox/activity",
        builder: (context, state) => const ActivityScreen(),
      ),
      GoRoute(
        path: "/inbox/chats",
        builder: (context, state) => const ChatsScreen(),
        routes: [
          GoRoute(
            path: "/:id",
            builder: (context, state) {
              final id = state.pathParameters["id"]!;
              final idInt = int.tryParse(id);
              try {
                if (idInt == null) {
                  throw GoException("Invalid id");
                }

                return ChatDetailScreen(id: idInt);
              } on GoException catch (e) {
                return ErrorScreen(error: e);
              }
            },
          ),
        ],
      ),
      GoRoute(
        path: "/profile/:username/settings",
        builder: (context, state) {
          final username = state.pathParameters["username"]!;
          return SettingsScreen();
        },
      ),
      GoRoute(
        path: "/video/recording",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: VideoRecordingScreen(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              final offsetAnimation = Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation);
              return SlideTransition(position: offsetAnimation, child: child);
            },
          );
        },
      ),
      GoRoute(
        path: "/video/preview",
        builder: (context, state) {
          final extra = state.extra as XFile;
          return VideoPreviewScreen(file: extra, isPicked: true);
        },
      ),
    ],
  );
});
