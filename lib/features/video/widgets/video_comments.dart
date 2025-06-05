import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok2/constants/gaps.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  final ScrollController _scrollController = ScrollController();

  bool _isWriting = false;

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          automaticallyImplyLeading: false,
          title: Text("Comments"),
          actionsPadding: EdgeInsets.only(right: 16),
          actions: [FaIcon(FontAwesomeIcons.xmark)],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            setState(() {
              _isWriting = false;
            });
          },
          child: Stack(
            children: [
              Scrollbar(
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: ListView.separated(
                    controller: _scrollController,
                    separatorBuilder: (context, index) => Gaps.v16,
                    padding: EdgeInsets.only(
                      top: 4,
                      bottom: 60,
                      left: 16,
                      right: 16,
                    ),

                    itemCount: 10,
                    itemBuilder:
                        (context, index) => Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(
                                "https://d1telmomo28umc.cloudfront.net/media/public/avatars/wills-1636619076.jpg",
                              ),
                            ),
                            Gaps.h8,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Willis",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "lorem ipsum dolor sit amet, consectetur adipiscing elit. lorem ipsum dolor sit amet, consectetur adipiscing elit.lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gaps.h8,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.heart,
                                  size: 20,
                                  color: Colors.grey.shade500,
                                ),
                                Gaps.v4,
                                Text(
                                  "52.4K",
                                  style: TextStyle(color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                          ],
                        ),
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                width: MediaQuery.of(context).size.width,
                child: BottomAppBar(
                  color: Colors.grey.shade100,
                  child: Row(
                    children: [
                      CircleAvatar(
                        foregroundImage: NetworkImage(
                          "https://d1telmomo28umc.cloudfront.net/media/public/avatars/wills-1636619076.jpg",
                        ),
                      ),
                      Gaps.h8,
                      Expanded(
                        child: TextField(
                          onTap: _onStartWriting,
                          expands: true,
                          minLines: null,
                          maxLines: null,
                          textInputAction: TextInputAction.newline,
                          scrollPadding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide(
                                color: Colors.grey.shade200,
                                width: 1,
                              ),
                            ),
                            hintText: "Add a comment...",
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.white,
                            labelStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.at,
                                    size: 24,
                                    color: Colors.grey.shade800,
                                  ),
                                  Gaps.h12,
                                  FaIcon(
                                    FontAwesomeIcons.gift,
                                    size: 24,
                                    color: Colors.grey.shade800,
                                  ),
                                  Gaps.h12,
                                  FaIcon(
                                    FontAwesomeIcons.faceSmile,
                                    size: 24,
                                    color: Colors.grey.shade800,
                                  ),
                                  Gaps.h12,
                                  if (_isWriting)
                                    GestureDetector(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        setState(() {
                                          _isWriting = false;
                                        });
                                      },
                                      child: FaIcon(
                                        FontAwesomeIcons.circleArrowUp,
                                        size: 24,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
