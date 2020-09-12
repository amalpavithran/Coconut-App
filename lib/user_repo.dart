import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/user.dart';

class UserRepositoryImpl {
  static UserDetails _currentUser;

  static UserDetails getCurrentUser() {
    return _currentUser;
  }

  static Future<String> updateUPI() async {
    Map<String, String> data = {"uid": FirebaseAuth.instance.currentUser.uid};
    final HttpsCallable callable =
        CloudFunctions.instance.getHttpsCallable(functionName: null);
    await callable.call(data).catchError((e) {
      return e;
    });
    return "Success";
  }

  static void updateUser(UserDetails user) {
    _currentUser = user;
  }
}
