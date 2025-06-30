import 'package:flutter/widgets.dart';
import 'package:tiktok2/features/video/models/playback_config_model.dart';
import 'package:tiktok2/features/video/repos/playback_config_repo.dart';

class PlaybackConfigVm extends ChangeNotifier {
  final PlaybackConfigRepo _repo;

  late final PlaybackConfigModel _model = PlaybackConfigModel(
    muted: _repo.getMuted(),
    autoPlay: _repo.getAutoPlay(),
  );

  PlaybackConfigVm(this._repo);

  void setMuted(bool value) {
    _repo.setMuted(value);
    _model.muted = value;
    notifyListeners();
  }

  bool get muted => _model.muted;

  void setAutoPlay(bool value) {
    _repo.setAutoPlay(value);
    _model.autoPlay = value;
    notifyListeners();
  }

  bool get autoPlay => _model.autoPlay;
}
