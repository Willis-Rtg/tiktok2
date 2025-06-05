import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok2/features/chats/chats_screen.dart';
import 'package:tiktok2/features/inbox/activity_screen.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  void _onDMPressed() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => ChatsScreen()));
  }

  void _onActivityTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ActivityScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text("Inbox"),
        actions: [
          IconButton(
            onPressed: () => _onDMPressed(),
            icon: FaIcon(FontAwesomeIcons.paperPlane),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () => _onActivityTap(),
            title: Text(
              "Activity",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            trailing: FaIcon(FontAwesomeIcons.chevronRight, size: 16),
          ),
          Container(
            height: 1,
            decoration: BoxDecoration(color: Colors.grey.shade300),
          ),
          ListTile(
            leading: Container(
              width: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: FaIcon(FontAwesomeIcons.users, color: Colors.white),
            ),
            title: Text(
              "New Followers",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text("Messages from followers will appear here"),
            trailing: FaIcon(FontAwesomeIcons.chevronRight, size: 16),
          ),
        ],
      ),
    );
  }
}
