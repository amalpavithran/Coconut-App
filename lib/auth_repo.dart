import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'models/user.dart';

abstract class AuthRepository {
  Future<String> login();
  Future<bool> silentLogin();
  Future<String> logout();
  Future<UserDetails> getUserDetails();
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<UserDetails> getUserDetails() async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    final HttpsCallable callable =
        CloudFunctions.instance.getHttpsCallable(functionName: "getUser");
    final HttpsCallableResult response =
        await callable.call({"uid": _auth.currentUser.uid}).catchError((e) {
      return e;
    });
  }

  @override
  Future<String> login() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await _auth.signInWithCredential(credential).catchError((e) {
      return e;
    });

    Map data = {
      "uid": _auth.currentUser.uid,
      "name": _auth.currentUser.displayName,
      "upiId": "null",
      "email": _auth.currentUser.email
    };

    final HttpsCallable callable =
        CloudFunctions.instance.getHttpsCallable(functionName: "login");
    final HttpsCallableResult response =
        await callable.call(data).catchError((e) {
      return e;
    });

    UserDetails user = await getUserDetails();

    print(response.data);

    // final HttpsCallable callable =
    //     CloudFunctions.instance.getHttpsCallable(functionName: "endTrip");
    // final HttpsCallableResult response = await callable.call().catchError((e) {
    //   return e;
    // });
    // if (response.data["message"] == "Ended") {
    //   //Implement get payments
    // }
    return "Success";
  }

  @override
  Future<String> logout() async {
    await FirebaseAuth.instance.signOut().catchError((e) {
      return e;
    });
    return "Success";
  }

  @override
  Future<bool> silentLogin() async {
    return (FirebaseAuth.instance.currentUser != null ? true : false);
  }
}
