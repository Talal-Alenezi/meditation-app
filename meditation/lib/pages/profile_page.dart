import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:meditation/providers/auth_povider.dart';
import 'package:meditation/theme/theme.dart';
import 'package:provider/provider.dart';

bool iconbool = true;
IconData _iconlight = Icons.sunny;
IconData _icondark = Icons.nights_stay;
var darkTheme;
var lightTheme;

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
              icon: Icon(Icons.logout)),
          IconButton(
              onPressed: () {
                setState(() {
                  iconbool = !iconbool;
                  if (iconbool == false) {
                    lightTheme = lightMode;
                  } else
                    darkTheme = darkMode;
                });
              },
              icon: Icon(iconbool ? _icondark : _iconlight))
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
