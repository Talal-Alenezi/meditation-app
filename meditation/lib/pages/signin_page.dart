import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meditation/models/User_model.dart';
import 'package:meditation/providers/auth_povider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInPage(),
    );
  }

  static of(BuildContext context) {}
}

class SignInPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signIn() {
    // Add your sign-in logic here
    String username = usernameController.text;
    String password = passwordController.text;

    // Add validation and sign-in logic as needed
    print('Username: $username');
    print('Password: $password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                ),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    final User user = User(
                        username: usernameController.text,
                        password: passwordController.text,
                        profileImagePath: ""); // hhhhhhhhhhhhhhhhhhhhhh
                    context
                        .read<AuthProvider>()
                        .signin(user: user)
                        .then((token) {
                      if (token.isNotEmpty) {
                        context.read<AuthProvider>().token = token;
                        print("SIGN IN TOKEN $token");
                        GoRouter.of(context).go("/homepage");
                      }
                      // Example: Print the username and password}
                    });
                  },
                  child: Text('Sign In',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 122, 128, 133),
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 6.0),
                TextButton(
                    onPressed: () {
                      context.go("/");
                    },
                    child: Text("Don't have an account? Sign up",
                        style: TextStyle(
                            color: Color.fromARGB(255, 155, 165, 173),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationThickness: .5))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
