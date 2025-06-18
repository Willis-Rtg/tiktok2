import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok2/constants/gaps.dart';
import 'package:tiktok2/features/discover/discover_screen.dart';
import 'package:tiktok2/features/inbox/inbox_screen.dart';
import 'package:tiktok2/features/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok2/features/user/user_profile_screen.dart';
import 'package:tiktok2/features/video/video_recording_screen.dart';
import 'package:tiktok2/features/video/video_timeline_screen.dart';
import 'package:tiktok2/utils.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key, this.tab = 0});

  final int tab;

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _selectedIndex;

  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void onPostVideoBtnTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VideoRecordingScreen(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.tab;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode(context) ? Colors.black : Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          AnimatedOpacity(
            opacity: _selectedIndex == 0 ? 1 : 0,
            duration: Duration(milliseconds: 300),
            child: VideoTimelineScreen(),
          ),
          Offstage(offstage: _selectedIndex != 1, child: DiscoverScreen()),
          Offstage(offstage: _selectedIndex != 2, child: Container()),
          Offstage(offstage: _selectedIndex != 3, child: InboxScreen()),
          Offstage(
            offstage: _selectedIndex != 4,
            child: UserProfileScreen(toFollow: false, username: "willis"),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            NavTab(
              icon: FontAwesomeIcons.house,
              selectedIcon: FontAwesomeIcons.house,
              label: " Home",
              isSelected: _selectedIndex == 0,
              onTap: () => onTap(0),
            ),
            NavTab(
              icon: FontAwesomeIcons.compass,
              selectedIcon: FontAwesomeIcons.solidCompass,
              label: "Discover",
              isSelected: _selectedIndex == 1,
              onTap: () => onTap(1),
            ),
            Gaps.h16,
            GestureDetector(
              onTap: () => onPostVideoBtnTap(),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 16,
                    top: 1,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    top: 1,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Color(0xff61D4F0),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 32,
                    decoration: BoxDecoration(
                      color:
                          isDarkMode(context)
                              ? Colors.grey.shade800
                              : Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: FaIcon(
                      FontAwesomeIcons.plus,
                      size: 22,
                      color:
                          isDarkMode(context)
                              ? Colors.grey.shade300
                              : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Gaps.h16,
            NavTab(
              icon: FontAwesomeIcons.message,
              selectedIcon: FontAwesomeIcons.solidMessage,
              label: "Inbox",
              isSelected: _selectedIndex == 3,
              onTap: () => onTap(3),
            ),
            NavTab(
              icon: FontAwesomeIcons.user,
              selectedIcon: FontAwesomeIcons.solidUser,
              label: "Profile",
              isSelected: _selectedIndex == 4,
              onTap: () => onTap(4),
            ),
          ],
        ),
      ),
    );
  }
}
