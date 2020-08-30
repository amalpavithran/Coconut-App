import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'models/user_groups.dart';

abstract class AuthRepository {
  Future<String> login();
  Future<String> logout();
  Future<List<UserGroups>> fetchGroups();
}

class AuthRepositoryImpl implements AuthRepository {
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
  Future<List<UserGroups>> fetchGroups() {
    // TODO: implement fetchGroups
    throw UnimplementedError();
  }
}
