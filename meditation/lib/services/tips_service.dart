import 'package:dio/dio.dart';
import 'package:meditation/models/tips_model.dart';
import 'package:meditation/services/cllient.dart';

class TipsServices {
  List<Tips> tips = [];
  Future<List<Tips>> getTips() async {
    try {
      final Response response = await ApiClient.get("/tips");

      tips = List.from(response.data).map((tip) => Tips.fromJson(tip)).toList();
      return tips;
    } catch (e) {
      throw e.toString();
    }
  }

  addTip(newTip) async {
    try {
      final Response response =
          await ApiClient.post("/tips", data: {"text": newTip});
      return response.data;
    } catch (e) {
      throw e.toString();
    }
  }
}
