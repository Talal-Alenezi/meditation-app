import 'package:flutter/material.dart';
import 'package:meditation/models/tips_model.dart';
import 'package:meditation/services/tips_service.dart';

class TipsProvider extends ChangeNotifier {
  List<Tips> tipsList = [];
  List<Tips> myTipsList = [];
  List<Tips> filteredTipsList = [];

  final _tipsService = TipsServices();

  Future<void> getTips() async {
    tipsList = await _tipsService.getTips();
    filteredTipsList = tipsList;
    notifyListeners();
  }

  Future<void> myTips(String username) async {
    final List<Tips> allTips = await _tipsService.getTips();

    myTipsList = allTips.where((tip) => tip.author == username).toList();
    notifyListeners();
  }

  addTip(newTip) async {
    await _tipsService.addTip(newTip);
    getTips();
  }

  void searchTips(String query) {
    if (query.isEmpty) {
      filteredTipsList = tipsList;
    } else {
      filteredTipsList = tipsList
          .where((tip) =>
              tip.text!.toLowerCase().contains(query.toLowerCase()) ||
              tip.author!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
