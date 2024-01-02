import 'package:flutter/material.dart';
import 'package:meditation/models/music_model.dart';
import 'package:meditation/services/musics.dart';

class MusicProvider extends ChangeNotifier {
  List<Music> musicList = [];

  final _musicService = MusicServices();

  Future<void> getMusic() async {
    musicList = await _musicService.getTracks();
    notifyListeners();
  }
}
