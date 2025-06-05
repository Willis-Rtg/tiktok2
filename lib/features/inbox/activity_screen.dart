import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok2/constants/gaps.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _notifications = List.generate(20, (index) => "${index}h");

  final List<Map<String, dynamic>> _tabs = [
    {"title": "All activity", "icon": FontAwesomeIcons.solidMessage},
    {"title": "Likes", "icon": FontAwesomeIcons.solidHeart},
    {"title": "Comments", "icon": FontAwesomeIcons.solidComments},
    {"title": "Mentions", "icon": FontAwesomeIcons.at},
    {"title": "Followers", "icon": FontAwesomeIcons.solidUser},
    {"title": "From TikTok", "icon": FontAwesomeIcons.tiktok},
  ];
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  bool _showBarrier = false;

  late final Animation<Offset> _offsetAnimation = Tween(
    begin: Offset(0, -1),
    end: Offset(0, 0),
  ).animate(_animationController);

  late final Animation<Color?> _colorAnimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black38,
  ).animate(_animationController);

  late final _animation = Tween<double>(
    begin: 0.0,
    end: 0.5,
  ).animate(_animationController);

  void _onDismissed(String notification) {
    setState(() {
      _notifications.remove(notification);
    });
  }

  void _toggleActivity() async {
    if (_animation.isCompleted) {
      await _animationController.reverse();
    } else {
      _animationController.forward();
    }

    setState(() {
      _showBarrier = !_showBarrier;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(onTap: _toggleActivity, child: Text("Activity")),
            Gaps.h4,
            RotationTransition(
              turns: _animation,
              child: FaIcon(FontAwesomeIcons.chevronDown, size: 16),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "New",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              ..._notifications.map(
                (notification) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Dismissible(
                    onDismissed: (direction) => _onDismissed(notification),
                    key: Key(notification),
                    background: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20),
                      color: Colors.green,
                      child: FaIcon(
                        FontAwesomeIcons.check,
                        color: Colors.white,
                      ),
                    ),
                    secondaryBackground: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      color: Colors.red,
                      child: FaIcon(
                        FontAwesomeIcons.trashCan,
                        color: Colors.white,
                      ),
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: FaIcon(FontAwesomeIcons.bell),
                      ),
                      title: RichText(
                        text: TextSpan(
                          text: "Account updates: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: "Upload longer videos ",
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                            TextSpan(
                              text: "${notification}h",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing: FaIcon(FontAwesomeIcons.chevronRight, size: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_showBarrier)
            AnimatedModalBarrier(
              color: _colorAnimation,
              dismissible: true,
              onDismiss: _toggleActivity,
            ),
          SlideTransition(
            position: _offsetAnimation,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                color: Colors.white,
              ),
              padding: EdgeInsets.only(left: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ..._tabs.map(
                    (tab) => ListTile(
                      leading: FaIcon(tab["icon"], size: 16),
                      title: Text(tab["title"]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
