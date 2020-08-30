import 'package:coconut_app/models/user.dart';

abstract class AuthRepository{
  Future<User> login(String username,String password);
  Future<void> logout();
}