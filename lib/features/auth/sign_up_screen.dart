import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktok2/constants/gaps.dart';
import 'package:tiktok2/features/auth/username_screen.dart';
import 'package:tiktok2/features/auth/login_screen.dart';
import 'package:tiktok2/features/auth/widgets/social_btn.dart';
import 'package:tiktok2/utils.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void onLogInTap(BuildContext context) async {
      context.push("/auth/login");
      // final result = await Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => LoginScreen(),
      //     // fullscreenDialog: true,
      //     // maintainState: true,
      //     // allowSnapshotting: true,
      //     // requestFocus: true,
      //   ),
      // );
    }

    void onEmailTap(BuildContext context) {
      context.push("/auth/username");

      // Navigator.of(context).push(
      //   PageRouteBuilder(
      //     transitionDuration: Duration(milliseconds: 1000),
      //     reverseTransitionDuration: Duration(milliseconds: 1000),
      //     pageBuilder:
      //         (context, animation, secondaryAnimation) => UsernameScreen(),
      //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //       final offsetAnimation = Tween<Offset>(
      //         begin: const Offset(1, 0),
      //         end: const Offset(0, 0),
      //       ).animate(animation);
      //       return SlideTransition(position: offsetAnimation, child: child);
      //     },
      //   ),
      // );
    }

    return Scaffold(
      body: OrientationBuilder(
        builder:
            (context, orientation) => SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Column(
                      children: [
                        Gaps.v80,
                        Text(
                          "Sign up for TikTok",
                          style: GoogleFonts.abrilFatface(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
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
                        Gaps.v20,
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width,
                          child: GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      orientation == Orientation.portrait
                                          ? 1
                                          : 2,
                                  childAspectRatio: 1,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  mainAxisExtent: 70,
                                ),
                            children: [
                              SocialBtn(
                                text: "Use phone or email",
                                color:
                                    isDarkMode(context)
                                        ? Colors.black
                                        : Colors.white,
                                onTap: () => onEmailTap(context),
                                icon: FontAwesomeIcons.envelope,
                              ),
                              SocialBtn(
                                text: "Continue with Apple",
                                color:
                                    isDarkMode(context)
                                        ? Colors.black
                                        : Colors.white,
                                onTap: () {},
                                icon: FontAwesomeIcons.apple,
                              ),
                              SocialBtn(
                                text: "Continue with Facebook",
                                color:
                                    isDarkMode(context)
                                        ? Colors.black
                                        : Colors.white,
                                onTap: () {},
                                icon: FontAwesomeIcons.facebook,
                              ),
                              SocialBtn(
                                text: "Continue with Google",
                                color:
                                    isDarkMode(context)
                                        ? Colors.black
                                        : Colors.white,
                                onTap: () {},
                                icon: FontAwesomeIcons.google,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
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
