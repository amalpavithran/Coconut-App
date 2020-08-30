import 'package:flutter/foundation.dart';

class UserDetails {
  final String name;
  final String placeholder;

  UserDetails({
    @required this.name,
    @required this.placeholder,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      name: null,
      placeholder: null,
    );
  }
}
