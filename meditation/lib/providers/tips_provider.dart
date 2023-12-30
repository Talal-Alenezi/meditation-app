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
}
