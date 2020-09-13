import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/pay_details.dart';
import '../../models/transaction.dart';
import '../../models/user.dart';
import '../../models/user_group.dart';


abstract class UserRepository {
  UserDetails getCurrentUser();
  Future<List<UserGroup>> getGroupData();
  Future<void> updateUser(UserDetails user);
  Future<void> updateGroup(Map<String, dynamic> groupData);
  Future<void> addGroup(Map<String, dynamic> groupData);
  Future<String> updateUPI(String upiId);
  Future<String> refresh();
}

class UserRepositoryImpl implements UserRepository {
  static UserDetails _currentUser;
  static List<UserGroup> _groupData;

  @override
  UserDetails getCurrentUser() {
    return _currentUser;
  }

  @override
  Future<List<UserGroup>> getGroupData() async {
    return _groupData;
  }

  @override
  Future<void> updateUser(UserDetails user) async {
    _currentUser = user;
  }

  @override
  Future<void> updateGroup(Map<String, dynamic> groupData) async {
    // groupData = response.data["groups"]
    List<UserGroup> groups = [];

    for (var group in groupData["groups"]) {
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
              upiID: user["upiId"]): group["credits"][user["uid"]]
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

  @override
  Future<void> addGroup(Map<String, dynamic> groupData) async {
    // groupData = response.data

    List<Map<UserDetails, double>> _groupInfo = [];
    List<Transaction> _transactions = [];
    List<PaymentDetails> _payments = [];
    bool _ended = false;

    for (var user in groupData["users"]) {
      _groupInfo.add({
        UserDetails(
            email: user["email"],
            name: user["name"],
            photoURL: user["profilePic"],
            upiID: user["upiId"]): groupData["credits"][user["uid"]]
      });
    }
    for (var transaction in groupData["transactions"]) {
      _transactions.add(Transaction(transaction["uid"], transaction["amount"]));
    }

    String groupName = groupData["name"];

    for (var paymentdetail in groupData["payments"]) {
      _ended = true;
      _payments.add(PaymentDetails(
          recieverUpiID: paymentdetail["upiId"],
          recieverName: paymentdetail["name"],
          transactionNote: "Dues for $groupName",
          amount: paymentdetail["amount"]));
    }

    _groupData.add(UserGroup(groupData["name"], groupData["groupId"],
        _groupInfo, _transactions, _payments, _ended));
  }

  @override
  Future<String> updateUPI(String upiId) async {
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

  @override
  Future<String> refresh() async {
    Map<String, String> data = {"uid": FirebaseAuth.instance.currentUser.uid};
    HttpsCallable callable =
        CloudFunctions.instance.getHttpsCallable(functionName: "getUser");
    final response = await callable.call(data).catchError((e) {
      return e;
    });
    User _firebaseuser = FirebaseAuth.instance.currentUser;
    updateUser(UserDetails(
        email: _firebaseuser.email,
        name: _firebaseuser.displayName,
        photoURL: _firebaseuser.photoURL,
        upiID: response.data["upiId"]));
    updateGroup(response.data);
    //update groupData

    return "Success";
  }
}
