import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok2/features/chats/chat_detail_screen.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  final List<int> _items = [];

  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(0);
      _items.insert(0, _items.length);
    }
  }

  void deleteItem(int index) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(index, (context, animation) {
        return _makeTile(index);
      });
      _items.removeAt(index);
    }
  }

  void onChatTap() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => ChatDetailScreen()));
  }

  Widget _makeTile(int index) {
    return ListTile(
      onLongPress: () => deleteItem(index),
      onTap: () => onChatTap(),
      leading: CircleAvatar(
        radius: 32,
        foregroundImage: NetworkImage(
          "https://kr-cdn.spooncast.net/profiles/9/reWGO9Uvmgjj3/fe80dbeb-bf0f-4eb3-9d14-351466881f36.jpg",
        ),
      ),
      title: Text(
        "John Doe",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        "Last message",
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
      trailing: Text(
        "2:15 PM",
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Direct Messages"),
        elevation: 1,
        actions: [
          IconButton(onPressed: _addItem, icon: FaIcon(FontAwesomeIcons.plus)),
        ],
      ),
      body: AnimatedList(
        key: _key,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index, animation) {
          return FadeTransition(
            key: UniqueKey(),
            opacity: animation,
            child: SizeTransition(
              axis: Axis.vertical,
              sizeFactor: animation,
              child: _makeTile(index),
            ),
          );
        },
      ),
    );
  }
}
