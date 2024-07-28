import 'dart:math';

import 'package:just_audio/just_audio.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Resources/app_sounds.dart';

class SoundPlayerComponent extends GlobalController {
  final _actionPlayer = AudioPlayer();
  final _musicPlayer = AudioPlayer();

  void playExplode() {
    int index = Random().nextInt(AppSounds.explodes.length);
    _actionPlayer.setAsset(AppSounds.explodes[index],preload: false).then((_) {
      _actionPlayer.play();
    });

    // _musicPlayer.setAsset(AppSounds.explodes[index],preload: false).then((_) {
    //   _musicPlayer.play();
    // });
  }

  @override
  void onInit() {
    _actionPlayer.setVolume(.25);
    _musicPlayer.setLoopMode(LoopMode.all);
    super.onInit();
  }

  @override
  void onClose() {
    _actionPlayer.dispose();
    super.onClose();
  }
}
