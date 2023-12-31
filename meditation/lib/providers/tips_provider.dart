import 'package:flutter/material.dart';
import 'package:meditation/models/tips_model.dart';
import 'package:meditation/services/tips_service.dart';

class TipsProvider extends ChangeNotifier {
  List<Tips> tipsList = [];

  final _tipsService = TipsServices();
  Future<void> getTips() async {
    tipsList = await _tipsService.getTips();

    notifyListeners();
  }

  Future<void> addTip(String newTip) async {
    try {
      await _tipsService.addTip(newTip);
      await getTips(); // Update the tips list after adding a new tip
    } catch (e) {
      print('Error adding tip: $e');
      // Handle the error as needed, for example, show a snackbar
    }
  }
}
