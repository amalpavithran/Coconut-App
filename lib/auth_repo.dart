import 'package:cloud_functions/cloud_functions.dart';
import 'package:coconut_app/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'models/user.dart';

abstract class AuthRepository {
  Future<UserDetails> login();
  Future<String> logout();
  bool silentLogin();
}

class AuthRepositoryImpl implements AuthRepository {
  final UserRepository userRepository;

  AuthRepositoryImpl(this.userRepository);
  @override
  Future<UserDetails> login() async {
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
      "upiId": "",
      "email": _auth.currentUser.email,
      "profilePic": _auth.currentUser.photoURL
    };

    final HttpsCallable callable =
        CloudFunctions.instance.getHttpsCallable(functionName: "login");
    final HttpsCallableResult response =
        await callable.call(data).catchError((e) {
      return e;
    });

    User _firebaseuser = _auth.currentUser;
    userRepository.updateUser(UserDetails(
        email: _firebaseuser.email,
        name: _firebaseuser.displayName,
        photoURL: _firebaseuser.photoURL,
        upiID: response.data["upiId"]));
    userRepository.updateGroup(response.data);
    return userRepository.getCurrentUser();
  }

  @override
  Future<String> logout() async {
    await FirebaseAuth.instance.signOut().catchError((e) {
      return e;
    });
    return "Success";
  }

  @override
  bool silentLogin() {
    return (FirebaseAuth.instance.currentUser != null ? true : false);
  }
}
