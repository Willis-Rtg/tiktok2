import 'package:flutter/material.dart';
import 'package:tiktok2/constants/gaps.dart';
import 'package:tiktok2/features/auth/widgets/next_btn.dart';
import 'package:tiktok2/features/main_navigation/main_navigation_screen.dart';
import 'package:tiktok2/utils.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

enum ESwipeDirection { left, right }

enum ECurrentPage { first, second }

class _TutorialScreenState extends State<TutorialScreen> {
  ESwipeDirection direction = ESwipeDirection.right;
  ECurrentPage currentPage = ECurrentPage.first;
  @override
  Widget build(BuildContext context) {
    void onPanUpdate(DragUpdateDetails details) {
      if (details.delta.dx > 0) {
        setState(() {
          direction = ESwipeDirection.right;
        });
      } else {
        setState(() {
          direction = ESwipeDirection.left;
        });
      }
    }

    void onPanEnd(DragEndDetails details) {
      if (direction == ESwipeDirection.right) {
        setState(() {
          currentPage = ECurrentPage.first;
        });
      } else {
        setState(() {
          currentPage = ECurrentPage.second;
        });
      }
    }

    return DefaultTabController(
      length: 3,
      child: GestureDetector(
        onPanUpdate: onPanUpdate,
        onPanEnd: onPanEnd,
        child: Scaffold(
          body: SafeArea(
            // child: TabBarView(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Gaps.v32,
            //           Text(
            //             "Watch cool videos",
            //             style: TextStyle(
            //               fontSize: 40,
            //               fontWeight: FontWeight.bold,
            //               height: 1.2,
            //             ),
            //           ),
            //           Gaps.v12,
            //           Text(
            //             "Videos are personalized for you based on what you watch, like, and share.",
            //             style: TextStyle(
            //               color: Colors.black45,
            //               fontSize: 16,
            //               fontWeight: FontWeight.w500,
            //               height: 1.2,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Gaps.v32,
            //           Text(
            //             "Follow the rules of the app",
            //             style: TextStyle(
            //               fontSize: 40,
            //               fontWeight: FontWeight.bold,
            //               height: 1.2,
            //             ),
            //           ),
            //           Gaps.v12,
            //           Text(
            //             "Videos are personalized for you based on what you watch, like, and share.",
            //             style: TextStyle(
            //               color: Colors.black45,
            //               fontSize: 16,
            //               fontWeight: FontWeight.w500,
            //               height: 1.2,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Gaps.v32,
            //           Text(
            //             "Enjoy the ride",
            //             style: TextStyle(
            //               fontSize: 40,
            //               fontWeight: FontWeight.bold,
            //               height: 1.2,
            //             ),
            //           ),
            //           Gaps.v12,
            //           Text(
            //             "Videos are personalized for you based on what you watch, like, and share.",
            //             style: TextStyle(
            //               color: Colors.black45,
            //               fontSize: 16,
            //               fontWeight: FontWeight.w500,
            //               height: 1.2,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            child: AnimatedCrossFade(
              firstChild: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v32,
                    Text(
                      "Watch cool videos",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    Gaps.v12,
                    Text(
                      "Videos are personalized for you based on what you watch, like, and share.",
                      style: TextStyle(
                        color:
                            isDarkMode(context)
                                ? Colors.grey.shade300
                                : Colors.black45,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              secondChild: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v32,
                    Text(
                      "Follow the rules of the app",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    Gaps.v12,
                    Text(
                      "Videos are personalized for you based on what you watch, like, and share.",
                      style: TextStyle(
                        color:
                            isDarkMode(context)
                                ? Colors.grey.shade300
                                : Colors.black45,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              crossFadeState:
                  currentPage == ECurrentPage.first
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
              duration: Duration(milliseconds: 300),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: isDarkMode(context) ? Colors.black : Colors.white,
            child: SizedBox(
              height: 80,
              child: AnimatedOpacity(
                opacity: currentPage == ECurrentPage.first ? 0 : 1,
                duration: Duration(milliseconds: 300),
                child: NextBtn(
                  disabled: currentPage == ECurrentPage.first,
                  text: "Next",
                  fn: (context) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const MainNavigationScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
