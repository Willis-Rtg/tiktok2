import 'package:flutter/material.dart';
import 'package:tiktok2/features/video/widgets/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 4;

  final PageController _pageController = PageController();

  final Duration _scrollDuration = Duration(milliseconds: 150);
  final Curve _scrollCurve = Curves.linear;

  void _onPageChanged(int page) {
    if (!mounted) return;
    _pageController.animateToPage(
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );

    if (page == _itemCount - 2) {
      _itemCount += 4;
      setState(() {});
    }
  }

  void _onVideoFinished() {
    _pageController.nextPage(duration: _scrollDuration, curve: _scrollCurve);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    return Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        onPageChanged: _onPageChanged,
        itemCount: _itemCount,
        itemBuilder:
            (context, index) =>
                VideoPost(onVideoFinished: _onVideoFinished, index: index),
      ),
    );
  }
}
