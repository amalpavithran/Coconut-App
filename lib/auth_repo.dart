import 'package:coconut_app/models/user.dart';

abstract class AuthRepository{
  Future<User> login(String username,String password);
  Future<void> logout();
}

class AuthRepositoryImpl implements AuthRepository{
  @override
  Future<User> login(String username, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}