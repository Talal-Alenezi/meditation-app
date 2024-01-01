import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meditation/models/User_model.dart';
import 'package:meditation/providers/auth_povider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  File? _image;

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void signUp() {
    // Add your sign-up logic here
    String username = usernameController.text;
    String password = passwordController.text;
    final profileImage = _image?.path ?? '';

    // Add validation and registration logic as needed
    print('Username: $username');
    print('Password: $password');
    print('profile image: $profileImage');

    // The rest of your sign-up logic
    final User user = User(
        username: username, password: password, profileImagePath: profileImage);
    context.read<AuthProvider>().signup(user: user).then((token) {
      if (token.isNotEmpty) {
        context.read<AuthProvider>().token = token;
        print("Username is ${user.username}, token is $token");

        // ("/homepage")
        GoRouter.of(context).go("/homepage");
      }
    });
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
          children: [
            SizedBox(
              height: 85,
            ),
            GestureDetector(
              onTap: _getImage,
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child:
                    _image == null ? Icon(Icons.camera_alt, size: 50.0) : null,
              ),
            ),
            SizedBox(height: 16.0),
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
              onPressed: signUp,
              child: Text('Sign Up'),
            ),
            SizedBox(height: 6.0),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go("/signin");
              },
              child: Text('Already have an account'),
            ),
          ],
        ),
      ),
    );
  }
}
