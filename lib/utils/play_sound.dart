import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class PlaySound {
  static playSound() async {
    AudioPlayer player = AudioPlayer();
    String audioasset = "assets/tap-sound.mp3";
    ByteData bytes = await rootBundle.load(audioasset);
    Uint8List soundbytes =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    await player.playBytes(soundbytes);
  }
}
