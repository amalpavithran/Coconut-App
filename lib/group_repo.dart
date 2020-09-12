import 'package:cloud_functions/cloud_functions.dart';
import 'package:coconut_app/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class GroupRepository {
  Future<String> createGroup(String groupName, String description);
  Future<String> joinGroup(String groupid);
  Future<String> leaveGroup(String groupid);
}

class GroupRepositoryImpl implements GroupRepository {
  @override
  Future<String> createGroup(String groupName, String description) async {
    Map data = {
      "name": groupName,
      "description": description,
      "users": [FirebaseAuth.instance.currentUser.uid]
    };
    final HttpsCallable callable =
        CloudFunctions.instance.getHttpsCallable(functionName: "createGroup");
    await callable.call(data).catchError((e) {
      return e.toString();
    });
    return "Success";
  }

  @override
  Future<String> joinGroup(String groupid) async {
    Map data = {
      "groupid": groupid,
      "uid": FirebaseAuth.instance.currentUser.uid,
    };
    final HttpsCallable callable =
        CloudFunctions.instance.getHttpsCallable(functionName: "joinGroup");
    final HttpsCallableResult response =
        await callable.call(data).catchError((e) {
      return e;
    });
    UserRepositoryImpl.addGroup(response.data);
    return "Success";
  }

  @override
  Future<String> leaveGroup(String groupid) async {
    Map data = {
      "groupid": groupid,
      "uid": FirebaseAuth.instance.currentUser.uid,
    };
    final HttpsCallable callable =
        CloudFunctions.instance.getHttpsCallable(functionName: "leaveGroup");
    await callable.call(data).catchError((e) {
      return e;
    });
    return "Success";
  }
}
