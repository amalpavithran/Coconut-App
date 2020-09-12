import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/user.dart';
import 'models/user_group.dart';

class UserRepositoryImpl {
  static UserDetails _currentUser;
  static List<UserGroup> groupData;

  static UserDetails getCurrentUser() {
    return _currentUser;
  }

  static Future<String> updateUPI(String upiId) async {
    _currentUser.upiID = upiId;

    Map<String, String> data = {
      "uid": FirebaseAuth.instance.currentUser.uid,
      "upiId": upiId
    };
    final HttpsCallable callable =
        CloudFunctions.instance.getHttpsCallable(functionName: "updateUser");
    await callable.call(data).catchError((e) {
      return e;
    });
    return "Success";
  }

  static void updateUser(UserDetails user) {
    _currentUser = user;
  }

  static Future<String> refresh() async {
    Map<String, String> data = {};
    HttpsCallable callable =
        CloudFunctions.instance.getHttpsCallable(functionName: null);
    await callable.call(data).catchError((e) {
      return e;
    });

    data = {};
    callable = CloudFunctions.instance.getHttpsCallable(functionName: null);
    await callable.call(data).catchError((e) {
      return e;
    });
    return "Success";
  }
}
