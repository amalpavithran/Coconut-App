import 'package:flutter/foundation.dart';

class UserDetails {
  final String email;
  final String name;
  final String photoURL;
  String upiID;

  UserDetails(
      {@required this.email,
      @required this.name,
      @required this.photoURL,
      @required this.upiID});
}
