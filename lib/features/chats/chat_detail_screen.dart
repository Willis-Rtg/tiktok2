import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok2/constants/gaps.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void unfocus() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        leadingWidth: 24,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(
                        "https://kr-cdn.spooncast.net/profiles/9/reWGO9Uvmgjj3/fe80dbeb-bf0f-4eb3-9d14-351466881f36.jpg",
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),
                  ],
                ),
                Gaps.h8,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Willis",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Active now",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FaIcon(FontAwesomeIcons.flag, size: 20),
                Gaps.h20,
                FaIcon(FontAwesomeIcons.ellipsis, size: 20),
              ],
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: unfocus,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemBuilder: (context, index) {
                final isMe = index % 2 == 0;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:
                      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.blue : Colors.red,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(isMe ? 12 : 2),
                          bottomRight: Radius.circular(isMe ? 2 : 12),
                        ),
                      ),
                      child: Text(
                        "This is message",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => Gaps.v16,
              itemCount: 10,
            ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Send a message...",
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.faceSmile,
                              color: Colors.grey,
                            ),
                            Gaps.h12,
                          ],
                        ),
                      ),
                      cursorHeight: 20,
                    ),
                  ),
                  Gaps.h20,
                  GestureDetector(
                    onTap: () {},
                    child: FaIcon(FontAwesomeIcons.paperPlane),
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
