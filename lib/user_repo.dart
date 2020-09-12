import 'package:cloud_functions/cloud_functions.dart';
import 'package:coconut_app/models/pay_details.dart';
import 'package:coconut_app/models/transaction.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/user.dart';
import 'models/user_group.dart';

class UserRepositoryImpl {
  static UserDetails _currentUser;
  static List<UserGroup> _groupData;

  static UserDetails getCurrentUser() {
    return _currentUser;
  }

  static List<UserGroup> getGroupData() {
    return _groupData;
  }

  static void updateUser(UserDetails user) {
    _currentUser = user;
  }

  static void updateGroup(var groupData) {
    // groupData = response.data["groups"]
    List<UserGroup> groups = [];

    for (var group in groupData) {
      List<Map<UserDetails, double>> _groupInfo = [];
      List<Transaction> _transactions = [];
      List<PaymentDetails> _payments = [];
      bool _ended = false;

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

      String groupName = group["name"];

      for (var paymentdetail in group["payments"]) {
        _ended = true;
        _payments.add(PaymentDetails(
            recieverUpiID: paymentdetail["upiId"],
            recieverName: paymentdetail["name"],
            transactionNote: "Dues for $groupName",
            amount: paymentdetail["amount"]));
      }

      groups.add(UserGroup(group["name"], group["groupId"], _groupInfo,
          _transactions, _payments, _ended));
    }
    _groupData = groups;
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
}
