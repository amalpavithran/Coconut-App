import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/user.dart';

abstract class GroupRepository {
  Future<void> createGroup(String groupName, String description);
  Future<void> joinGroup(String groupid);
}

class Group implements GroupRepository {
  @override
  Future<void> createGroup(String groupName, String description) async {
    Map data = {
      "name": groupName,
      "description": description,
      "users": [FirebaseAuth.instance.currentUser.uid]
    };
    final HttpsCallable callable =
        CloudFunctions.instance.getHttpsCallable(functionName: "createGroup");
    final HttpsCallableResult response = await callable.call(data);
  }

  @override
  Future<void> joinGroup() {
    // TODO: implement joinGroup
    throw UnimplementedError();
  }
}
