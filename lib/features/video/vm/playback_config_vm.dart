import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok2/features/video/models/playback_config_model.dart';
import 'package:tiktok2/features/video/repos/playback_config_repo.dart';

class PlaybackConfigVm extends Notifier<PlaybackConfigModel> {
  final PlaybackConfigRepo _repo;

  @override
  PlaybackConfigModel build() {
    return PlaybackConfigModel(
      muted: _repo.getMuted(),
      autoPlay: _repo.getAutoPlay(),
    );
  }

  PlaybackConfigVm(this._repo);

  void setMuted(bool value) {
    _repo.setMuted(value);
    state = PlaybackConfigModel(muted: value, autoPlay: state.autoPlay);
  }

  void setAutoPlay(bool value) {
    _repo.setAutoPlay(value);
    state = PlaybackConfigModel(muted: state.muted, autoPlay: value);
  }
}

final playbackConfigProvider =
    NotifierProvider<PlaybackConfigVm, PlaybackConfigModel>(
      () => throw UnimplementedError(),
    );
