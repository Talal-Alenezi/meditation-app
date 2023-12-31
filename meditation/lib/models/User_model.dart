// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// import 'package:image_picker/image_picker.dart';

class User {
  final int? id;
  final String username;
  final String password;
  final String profileImagePath; // Store the image path instead of XFile
  User({
    this.id,
    required this.username,
    required this.password,
    required this.profileImagePath,
  });

  User copyWith({
    int? id,
    String? username,
    String? password,
    String? profileImagePath,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      profileImagePath: profileImagePath ?? this.profileImagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'password': password,
      'profileImagePath': profileImagePath,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as int : null,
      username: map['username'] as String,
      password: map['password'] as String,
      profileImagePath: map['profileImagePath'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, username: $username, password: $password, profileImagePath: $profileImagePath)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.password == password &&
        other.profileImagePath == profileImagePath;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        password.hashCode ^
        profileImagePath.hashCode;
  }
}
