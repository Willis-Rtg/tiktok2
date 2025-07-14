import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gal/gal.dart';
import 'package:tiktok2/features/video/models/video_model.dart';
import 'package:tiktok2/features/video/vm/timeline_vm.dart';
import 'package:tiktok2/features/video/vm/upload_vm.dart';
import 'package:tiktok2/utils.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends ConsumerStatefulWidget {
  const VideoPreviewScreen({
    super.key,
    required this.file,
    required this.isPicked,
  });

  final XFile file;
  final bool isPicked;

  @override
  ConsumerState<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends ConsumerState<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController;
  bool _isSaving = false;

  Future<void> _initVideo() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.file.path));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
    setState(() {});
  }

  Future<void> _saveToGallery() async {
    if (_isSaving) return;

    await Gal.putVideo(widget.file.path, album: "TikTok Clone");

    _isSaving = true;

    setState(() {});
  }

  Future<void> _uploadPressed(file) async {
    ref
        .read(uploadVMProvider.notifier)
        .uploadVideo(File(widget.file.path), context);
  }

  @override
  void initState() {
    super.initState();

    _initVideo();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Preview video"),
        actions: [
          if (!widget.isPicked)
            IconButton(
              onPressed: _saveToGallery,
              icon: FaIcon(
                _isSaving ? FontAwesomeIcons.check : FontAwesomeIcons.download,
              ),
            ),
          IconButton(
            onPressed:
                ref.watch(uploadVMProvider).isLoading
                    ? null
                    : () => _uploadPressed(widget.file),
            icon:
                ref.watch(uploadVMProvider).isLoading
                    ? const CircularProgressIndicator()
                    : FaIcon(
                      FontAwesomeIcons.cloudArrowUp,
                      color: isDarkMode(context) ? Colors.white : Colors.black,
                    ),
          ),
        ],
      ),
      body:
          _videoPlayerController.value.isInitialized
              ? Stack(
                alignment: Alignment.center,
                children: <Widget>[
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
              : const Center(child: CircularProgressIndicator()),
    );
  }
}
