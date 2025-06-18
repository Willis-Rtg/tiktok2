import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok2/constants/gaps.dart';
import 'package:tiktok2/features/video/video_preview_screen.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _isSelfieMode = false;
  late FlashMode _flashMode;
  final List _flashModes = [FlashMode.always, FlashMode.auto, FlashMode.off];
  final List _flashModeIcons = [
    Icons.flash_off_rounded,
    Icons.flash_on_rounded,
    Icons.flash_auto_rounded,
  ];
  late int _flashModeIndex;

  late CameraController _cameraController;
  late final AnimationController _buttonAnimationController =
      AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 300),
      );
  late final Animation<double> _buttonAnimation = Tween<double>(
    begin: 1,
    end: 1.3,
  ).animate(_buttonAnimationController);
  late final AnimationController _recordingAnimationController =
      AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
        reverseDuration: const Duration(milliseconds: 300),
      );
  late final Animation<double> _recordingAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(_recordingAnimationController);

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) return;

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 0 : 1],
      ResolutionPreset.high,
      enableAudio: false,
    );
    if (!_cameraController.value.isInitialized) {
      await _cameraController.initialize();
    }

    await _cameraController.prepareForVideoRecording();

    _flashMode = _cameraController.value.flashMode;
    _flashModeIndex = _flashModes.indexOf(_flashMode);
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();
    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();
      setState(() {});
    }
  }

  Future<void> toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> setFlashMode(FlashMode newFlashMode) async {
    _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    _flashModeIndex++;
    setState(() {});
  }

  Future<void> _startRecording(TapDownDetails details) async {
    if (!mounted) return;
    if (_cameraController.value.isRecordingVideo) return;
    await _cameraController.startVideoRecording();
    _buttonAnimationController.forward();
    _recordingAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;

    _buttonAnimationController.reverse();
    _recordingAnimationController.reverse();

    final file = await _cameraController.stopVideoRecording();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(file: file, isPicked: false),
      ),
    );
  }

  Future<void> _onPickVideo() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (video == null) return;

    // print(video);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(file: video, isPicked: true),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (!_hasPermission) initPermissions();
    _recordingAnimationController.addListener(() {
      setState(() {});
    });
    _recordingAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _buttonAnimationController.dispose();
    _recordingAnimationController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (!_hasPermission) return;
    if (!_cameraController.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      await _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      await initCamera();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   foregroundColor: Colors.white,
      //   title: Text("Recording video", style: TextStyle(color: Colors.white)),
      //   backgroundColor: Colors.black,
      // ),
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child:
            !_hasPermission || !_cameraController.value.isInitialized
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Requesting permission...",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Gaps.v20,
                    CircularProgressIndicator.adaptive(),
                  ],
                )
                : Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(child: CameraPreview(_cameraController)),
                    Positioned(
                      top: 32,
                      left: 0,
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () => Navigator.pop(context),
                        icon: FaIcon(FontAwesomeIcons.xmark),
                      ),
                    ),
                    Positioned(
                      top: 32,
                      left: 36,
                      child: IconButton(
                        color: Colors.white,
                        onPressed: toggleSelfieMode,
                        icon: FaIcon(FontAwesomeIcons.cameraRotate),
                      ),
                    ),
                    Positioned(
                      top: 32,
                      left: 72,
                      child: IconButton(
                        color: Colors.white,
                        onPressed:
                            () =>
                                setFlashMode(_flashModes[_flashModeIndex % 3]),
                        icon: Icon(_flashModeIcons[_flashModeIndex % 3]),
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width,

                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTapDown: _startRecording,
                                onTapUp: (details) {
                                  _stopRecording();
                                },
                                child: ScaleTransition(
                                  scale: _buttonAnimation,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: 64,
                                        height: 64,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 72,
                                        height: 72,
                                        child: CircularProgressIndicator(
                                          color: Theme.of(context).primaryColor,
                                          strokeWidth: 4,
                                          value: _recordingAnimation.value,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            right: MediaQuery.of(context).size.width * 0.15,
                            child: IconButton(
                              color: Colors.white,
                              onPressed: _onPickVideo,
                              icon: FaIcon(FontAwesomeIcons.image),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
