import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok2/constants/gaps.dart';
import 'package:tiktok2/features/auth/login_submit_screen.dart';
import 'package:tiktok2/features/auth/vm/social_auth_vm.dart';
import 'package:tiktok2/features/auth/widgets/social_btn.dart';
import 'package:tiktok2/utils.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    void onSignUpTap() {
      context.pop();
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Gaps.v80,
              Text(
                "Log in for TikTok",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Gaps.v20,
              Text(
                "Create a profile, follow other accounts, make your own videos, and more.",
                style: TextStyle(
                  color:
                      isDarkMode(context)
                          ? Colors.grey.shade300
                          : Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              Gaps.v40,
              SocialBtn(
                text: "Use phone or email",
                color: isDarkMode(context) ? Colors.black : Colors.white,
                onTap:
                    () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginSubmitScreen(),
                      ),
                    ),
                icon: FontAwesomeIcons.envelope,
              ),
              Gaps.v12,
              SocialBtn(
                text: "Continue with github",
                color: isDarkMode(context) ? Colors.black : Colors.white,
                onTap: () {
                  ref.read(socialAuthProvider.notifier).githubLogin(context);
                },
                icon: FontAwesomeIcons.github,
              ),
              Gaps.v12,
              SocialBtn(
                text: "Continue with Facebook",
                color: isDarkMode(context) ? Colors.black : Colors.white,
                onTap: () {},
                icon: FontAwesomeIcons.facebook,
              ),
              Gaps.v12,
              SocialBtn(
                text: "Continue with Google",
                color: isDarkMode(context) ? Colors.black : Colors.white,
                onTap: () {},
                icon: FontAwesomeIcons.google,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account?"),
              Gaps.h4,
              GestureDetector(
                onTap: onSignUpTap,
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
