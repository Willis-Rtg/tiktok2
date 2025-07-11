import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok2/features/video/models/video_model.dart';

class TimelineVm extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> _list = [];

  @override
  FutureOr<List<VideoModel>> build() async {
    await Future.delayed(const Duration(seconds: 1));

    return _list;
  }

  Future<void> addVideo(VideoModel video) async {
    state = AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 1));
    _list = [..._list, video];
    state = AsyncValue.data(_list);
  }
}

final timelineProvider = AsyncNotifierProvider<TimelineVm, List<VideoModel>>(
  () => TimelineVm(),
);
