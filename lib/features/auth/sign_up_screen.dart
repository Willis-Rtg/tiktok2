import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok2/constants/gaps.dart';
import 'package:tiktok2/features/auth/username_screen.dart';
import 'package:tiktok2/features/auth/login_screen.dart';
import 'package:tiktok2/features/auth/widgets/social_btn.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void onLogInTap(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
          maintainState: true,
          fullscreenDialog: true,
          allowSnapshotting: true,
          requestFocus: true,
        ),
      );
    }

    void onEmailTap(BuildContext context) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => UsernameScreen()));
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Gaps.v80,
              Text(
                "Sign up for TikTok",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Gaps.v20,
              Text(
                "Create a profile, follow other accounts, make your own videos, and more.",
                style: TextStyle(color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              Gaps.v40,
              SocialBtn(
                text: "Use phone or email",
                color: Colors.white,
                onTap: () => onEmailTap(context),
                icon: FontAwesomeIcons.envelope,
              ),
              Gaps.v12,
              SocialBtn(
                text: "Continue with Apple",
                color: Colors.white,
                onTap: () {},
                icon: FontAwesomeIcons.apple,
              ),
              Gaps.v12,
              SocialBtn(
                text: "Continue with Facebook",
                color: Colors.white,
                onTap: () {},
                icon: FontAwesomeIcons.facebook,
              ),
              Gaps.v12,
              SocialBtn(
                text: "Continue with Google",
                color: Colors.white,
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
              Text("Already have an account?"),
              Gaps.h4,
              GestureDetector(
                onTap: () => onLogInTap(context),
                child: Text(
                  "Log in",
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
