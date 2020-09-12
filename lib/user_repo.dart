import 'package:cloud_functions/cloud_functions.dart';
import 'package:coconut_app/models/transaction.dart';
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
    Map<String, String> data = {"uid": FirebaseAuth.instance.currentUser.uid};
    HttpsCallable callable =
        CloudFunctions.instance.getHttpsCallable(functionName: "getUser");
    final response = await callable.call(data).catchError((e) {
      return e;
    });
    updateGroup(response.data["groups"]);
    //update groupData

    return "Success";
  }

  static void updateGroup(var groupData) {
    List<UserGroup> groups = [];

    for (var group in groupData) {
      List<Map<UserDetails, double>> _groupInfo = [];
      List<Transaction> _transactions;

      for (var user in group["users"]) {
        _groupInfo.add({
          UserDetails(
              email: user["email"],
              name: user["name"],
              photoURL: user["profilePic"],
              upiID: user["upiId"]): user["amount"]
        });
      }
      for (var transaction in group["transactions"]) {
        _transactions
            .add(Transaction(transaction["uid"], transaction["amount"]));
      }

      groups.add(UserGroup(
          group["name"], group["groupId"], _groupInfo, _transactions));
    }
  }
}
