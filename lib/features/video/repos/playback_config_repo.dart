import 'package:shared_preferences/shared_preferences.dart';

class PlaybackConfigRepo {
  final SharedPreferences _preference;

  PlaybackConfigRepo(this._preference);

  Future<void> setMuted(bool muted) async {
    await _preference.setBool("muted", muted);
  }

  bool getMuted() {
    return _preference.getBool("muted") ?? false;
  }

  Future<void> setAutoPlay(bool autoPlay) async {
    await _preference.setBool("autoPlay", autoPlay);
  }

  bool getAutoPlay() {
    return _preference.getBool("autoPlay") ?? false;
  }
}
