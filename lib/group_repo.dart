import 'package:cloud_functions/cloud_functions.dart';
import 'package:coconut_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class GroupRepository {
  Future<String> createGroup(String groupName, String description);
  Future<String> joinGroup(String groupid);
  Future<String> leaveGroup(String groupid);
}

class GroupRepositoryImpl implements GroupRepository {
  Future<UserDetails> _getUserDetails() async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    final HttpsCallable callable =
        CloudFunctions.instance.getHttpsCallable(functionName: "getUser");
    final HttpsCallableResult response =
        await callable.call({"uid": _auth.currentUser.uid}).catchError((e) {
      return e;
    });
  }

  @override
  Future<String> createGroup(String groupName, String description) async {
    Map data = {
      "name": groupName,
      "description": description,
      "users": [FirebaseAuth.instance.currentUser.uid]
    };
    final HttpsCallable callable =
        CloudFunctions.instance.getHttpsCallable(functionName: "createGroup");
    final HttpsCallableResult response =
        await callable.call(data).catchError((e) {
      return e.toString();
    });
    return response.data;
  }

  @override
  Future<String> joinGroup(String groupid) async {
    Map data = {
      "uid": FirebaseAuth.instance.currentUser.uid,
      "groupid": groupid
    };
    //enter this after the function is made
    // final HttpsCallable callable =
    //     CloudFunctions.instance.getHttpsCallable(functionName: null);
    // final HttpsCallableResult response = await callable.call(data);
    return "Success";
  }

  @override
  Future<String> leaveGroup(String groupid) async {
    Map data = {
      "uid": FirebaseAuth.instance.currentUser.uid,
      "groupid": groupid
    };
    //enter this after the function is made
    // final HttpsCallable callable =
    //     CloudFunctions.instance.getHttpsCallable(functionName: null);
    // final HttpsCallableResult response = await callable.call(data);
    return "Success";
  }
}
