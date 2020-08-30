import 'package:flutter/foundation.dart';

class User {
  final String name;
  final String placeholder;

  User({
    @required this.name,
    @required this.placeholder,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: null,
      placeholder: null,
    );
  }
}
