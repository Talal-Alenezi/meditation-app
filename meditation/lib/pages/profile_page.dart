import 'dart:js';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:meditation/models/User_model.dart';
import 'package:meditation/providers/auth_povider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final token = context.watch<AuthProvider>().token;
    //   if (token.isNotEmpty && JwtDecoder.getExpirationDate(token)!.isAfter(DateTime.now())) {
    //   user = User.fromJson(Jwt.parseJwt(token));

    // }
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Center(
        child: Consumer<AuthProvider>(
          builder: (context, value, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(""),
              ),
              SizedBox(height: 20),
              Text(""),
              SizedBox(height: 20),
              Text(
                'Finished Exercises:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
