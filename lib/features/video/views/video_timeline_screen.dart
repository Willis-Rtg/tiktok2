import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok2/features/video/vm/timeline_vm.dart';
import 'package:tiktok2/features/video/widgets/video_post.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  ConsumerState<VideoTimelineScreen> createState() =>
      _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
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
    return ref
        .watch(timelineProvider)
        .when(
          loading: () => Center(child: CircularProgressIndicator()),
          error:
              (error, stackTrace) => Center(
                child: Text(
                  "Could not load videos: ${error.toString()}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
          data:
              (data) => RefreshIndicator(
                onRefresh: _onRefresh,
                child: PageView.builder(
                  scrollDirection: Axis.vertical,
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: data.length,
                  itemBuilder:
                      (context, index) => VideoPost(
                        onVideoFinished: _onVideoFinished,
                        index: index,
                      ),
                ),
              ),
        );
  }
}
