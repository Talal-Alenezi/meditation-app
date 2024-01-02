import 'package:dio/dio.dart';

import 'package:meditation/models/music_model.dart';
import 'package:meditation/services/cllient.dart';

class MusicServices {
  List<Music> music = [];

  Future<List<Music>> getTracks() async {
    try {
      final Response response = await ApiClient.get("/music");

      music = List.from(response.data)
          .map((music) => Music.fromJson(music))
          .toList();
      return music;
    } catch (e) {
      throw e.toString();
    }
  }
}
