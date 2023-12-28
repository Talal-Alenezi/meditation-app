import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meditation/models/User_model.dart';
import 'package:meditation/providers/auth_povider.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signUp() {
    // Add your sign-up logic here
    String username = usernameController.text;
    String password = passwordController.text;

    // Add validation and registration logic as needed
    print('Username: $username');
    print('Password: $password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText:
                    'Must contain at least one letter and one number, and at least 8 characters',
              ),
              obscureText: true,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                final User user = User(
                    username: usernameController.text,
                    password: passwordController.text);
                context.read<AuthProvider>().signup(user: user).then((token) {
                  if (token.isNotEmpty) {
                    print("token is $token");
                    GoRouter.of(context).go("/homepage");
                  }
                });
              },
              child: Text('Sign Up'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                // Navigate to login page or perform relevant action
              },
              child: Text('Already have an account'),
            ),
          ],
        ),
      ),
    );
  }
}
