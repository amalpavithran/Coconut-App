import 'package:coconut_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'models/user.dart';
import 'models/user.dart';
import 'models/user.dart';
import 'models/user.dart';

abstract class AuthRepository {
  Future<String> login();
  Future<String> logout();
  UserDetails getUserDetails();
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
  UserDetails getUserDetails() {
    User _user = FirebaseAuth.instance.currentUser;
    UserDetails userDetails = UserDetails(
        email: _user.email, name: _user.displayName, photoURL: _user.photoURL);
    return userDetails;
  }
}
