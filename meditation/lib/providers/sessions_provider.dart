import 'package:flutter/material.dart';
import 'package:meditation/models/sessions_model.dart';
import 'package:meditation/services/sessions_service.dart';

class SessionProvider extends ChangeNotifier {
  List<SessionModel> sessionsList = [];

  final _sessionService = SessionsService();

  Future<void> getSessions() async {
    sessionsList = await _sessionService.getSessions();
    notifyListeners();
  }
}
