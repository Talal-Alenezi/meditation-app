import 'package:flutter/material.dart';
import 'package:meditation/models/execrsices_model.dart';
import 'package:meditation/services/exercises.dart';

class ExercisesProvider extends ChangeNotifier {
  List<ExercisesModel> exercisesList = [];

  final _exercisesService = ExercisesServices();

  Future<void> getExercises() async {
    exercisesList = await _exercisesService.getExercises();
    notifyListeners();
  }
}
