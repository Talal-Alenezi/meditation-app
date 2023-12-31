import 'package:dio/dio.dart';
import 'package:meditation/models/execrsices_model.dart';
import 'package:meditation/services/cllient.dart';

class ExercisesServices {
  List<ExercisesModel> exercises = [];
  Future<List<ExercisesModel>> getExercises() async {
    try {
      final Response response = await ApiClient.get("/exercises");

      exercises = List.from(response.data)
          .map((exercise) => ExercisesModel.fromJson(exercise))
          .toList();
      return exercises;
    } catch (e) {
      throw e.toString();
    }
  }
}
