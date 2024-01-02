import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:meditation/providers/auth_povider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    String username = '';
    final token = context.watch<AuthProvider>().token;
    if (token.isNotEmpty) {
      Map<String, dynamic>? decodedToken = Jwt.parseJwt(token);
      username = decodedToken['username'];
      print('Username from token: $username');
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [
          IconButton(
              onPressed: () {
                context.go("/signin");
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Consumer<AuthProvider>(
          builder: (context, value, child) => Column(
            children: [
              SizedBox(height: 40),
              CircleAvatar(
                radius: 50,
                backgroundColor: Color.fromARGB(255, 202, 238, 255),
                backgroundImage: NetworkImage(""), //user image
              ),
              SizedBox(height: 20),
              Text(username,
                  style: TextStyle(
                      color: const Color.fromARGB(255, 92, 97, 100),
                      fontSize: 20,
                      fontWeight: FontWeight.w800)),
              SizedBox(height: 5),
              Divider(
                  color: const Color.fromARGB(255, 122, 128, 133),
                  endIndent: 20,
                  indent: 20),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text('Finished Exercises:',
                      style: TextStyle(
                          color: Color.fromARGB(255, 92, 97, 100),
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
