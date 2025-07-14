import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok2/constants/gaps.dart';
import 'package:tiktok2/features/video/vm/playback_config_vm.dart';
import 'package:tiktok2/features/video/widgets/video_btn.dart';
import 'package:tiktok2/features/video/widgets/video_comments.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends ConsumerStatefulWidget {
  final Function onVideoFinished;
  final int index;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  _VideoPostState createState() => _VideoPostState();
}

class _VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video1.mp4");
  bool _isPlaying = true;
  late final AnimationController _animationController;

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    if (!mounted) return;
    await _videoPlayerController.initialize();
    if (ref.watch(playbackConfigProvider).autoPlay) {
      _videoPlayerController.play();
      _isPlaying = true;
    }
    if (kIsWeb) {
      _videoPlayerController.setVolume(0);
    }
    _videoPlayerController.addListener(_onVideoChange);

    if (ref.watch(playbackConfigProvider).muted) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(1);
    }

    setState(() {});
  }

  void _onTogglePause() {
    if (!mounted) return;
    if (_videoPlayerController.value.isInitialized &&
        _videoPlayerController.value.isPlaying) {
      _isPlaying = false;
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _isPlaying = true;
      _videoPlayerController.play();
      _animationController.forward();
    }

    setState(() {});
  }

  void _onCommentTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    await showModalBottomSheet(
      context: context,
      builder: (context) => VideoComments(),
      isScrollControlled: true,
      // backgroundColor: isDarkMode(context) ? Colors.black : Colors.white,
    );
    _onTogglePause();
  }

  void toggleVolume() {
    if (!mounted) return;
    ref
        .read(playbackConfigProvider.notifier)
        .setMuted(!ref.read(playbackConfigProvider).muted);

    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.volume == 0) {
        _videoPlayerController.setVolume(1);
      } else {
        _videoPlayerController.setVolume(0);
      }
    }
    setState(() {});
  }

  void _onVisibilityChanged(VisibilityInfo visibilityInfo) {
    // if (visibilityInfo.visibleFraction == 0 &&
    //     _videoPlayerController.value.isPlaying &&
    //     !_isPlaying) {
    //   _videoPlayerController.pause();
    // } else if (visibilityInfo.visibleFraction == 1 &&
    //     !_videoPlayerController.value.isPlaying &&
    //     _isPlaying) {
    //   if (context.read<PlaybackConfigVm>().autoPlay) {
    //     _videoPlayerController.play();
    //   }
    // }
    if (visibilityInfo.visibleFraction == 0 &&
        _videoPlayerController.value.isInitialized &&
        _videoPlayerController.value.isPlaying) {
      _onTogglePause();
    } else if (visibilityInfo.visibleFraction == 1 &&
        _videoPlayerController.value.isInitialized &&
        !_videoPlayerController.value.isPlaying) {
      if (ref.read(playbackConfigProvider).autoPlay) {
        _onTogglePause();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    _initVideoPlayer();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      upperBound: 1.5,
      lowerBound: 1,
      value: 1.5,
    );
    // _animationController.addListener(() {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    if (!mounted) return;

    if (_videoPlayerController.value.isInitialized) {
      _videoPlayerController.dispose();
    }

    _videoPlayerController.removeListener(_onVideoChange);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("video_post_${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child:
                _videoPlayerController.value.isInitialized
                    ? Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: -MediaQuery.of(context).size.width / 2,
                          right: -MediaQuery.of(context).size.width / 2,
                          bottom: 0,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: SizedBox(
                              width: _videoPlayerController.value.size.width,
                              height: _videoPlayerController.value.size.height,
                              child: VideoPlayer(_videoPlayerController),
                            ),
                          ),
                        ),
                      ],
                    )
                    : Container(color: Colors.black),
          ),
          Positioned.fill(child: GestureDetector(onTap: _onTogglePause)),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder:
                      (context, child) => Transform.scale(
                        scale: _animationController.value,
                        child: child,
                      ),
                  child: AnimatedOpacity(
                    opacity: _isPlaying ? 0 : 1,
                    duration: const Duration(milliseconds: 300),
                    child: FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: 52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "@hello",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gaps.v8,
                Text(
                  "This is my house in Thailand!!!",
                  style: TextStyle(color: Colors.grey.shade400),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              children: [
                VideoBtn(
                  icon:
                      _videoPlayerController.value.volume == 0
                          ? FontAwesomeIcons.volumeOff
                          : FontAwesomeIcons.volumeHigh,
                  onTap: toggleVolume,
                  text: _videoPlayerController.value.volume == 0 ? "off" : "on",
                ),
                Gaps.v16,
                CircleAvatar(
                  radius: 24,
                  foregroundColor: Theme.of(context).primaryColor,
                  backgroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                    "https://d1telmomo28umc.cloudfront.net/media/public/avatars/wills-1636619076.jpg",
                  ),
                ),
                Gaps.v16,
                VideoBtn(
                  icon: FontAwesomeIcons.heart,
                  onTap: () {},
                  text: "33K",
                ),
                Gaps.v16,
                VideoBtn(
                  icon: FontAwesomeIcons.message,
                  onTap: () => _onCommentTap(context),
                  text: "5.5K",
                ),
                Gaps.v12,
                VideoBtn(icon: FontAwesomeIcons.share, onTap: () {}, text: ""),
                Gaps.v4,
                CircleAvatar(
                  radius: 24,
                  foregroundColor: Theme.of(context).primaryColor,
                  backgroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                    "https://d1telmomo28umc.cloudfront.net/media/public/avatars/wills-1636619076.jpg",
                  ),
                  child: Text("Willis"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
