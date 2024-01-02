import 'package:dio/dio.dart';
import 'package:meditation/models/sessions_model.dart';
import 'package:meditation/services/cllient.dart';

class SessionsService {
  List<SessionModel> sessions = [];
  Future<List<SessionModel>> getSessions() async {
    try {
      final Response response = await ApiClient.get("/meditation");

      sessions = List.from(response.data)
          .map((exercise) => SessionModel.fromJson(exercise))
          .toList();
      return sessions;
    } catch (e) {
      throw e.toString();
    }
  }
}
