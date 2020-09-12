import 'package:coconut_app/models/user_group.dart';
import 'package:flutter/foundation.dart';

class UserDetails {
  final String email;
  final String name;
  final String photoURL;
  String upiID;
  final List<String> groups;

  UserDetails(
      {@required this.email,
      @required this.name,
      @required this.photoURL,
      @required this.groups,
      @required this.upiID});
}
