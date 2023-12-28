import 'package:dio/dio.dart';

import 'package:meditation/models/User_model.dart';
import 'package:meditation/services/cllient.dart';

class AuthService {
  Future<String> signup({required User user}) async {
    late String token;
    try {
      if (user.username.isNotEmpty && user.password.isNotEmpty) {
        final Response responese =
            await ApiClient.dio.post("/signup", data: user.toJson());
        return token = responese.data["token"];
      } else
        return "";
    } catch (e) {
      throw "password or username invalid";
    }
  }
}
