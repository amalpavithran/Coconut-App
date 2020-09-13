import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repos/auth_repo.dart';
import '../../../models/user.dart';
import '../../repos/user_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  LoginCubit(this.authRepository, this.userRepository): super(LoginInitial());

  void login() async {
    emit(LoginLoading());
    try {
      final result = await authRepository.login();
      if (result is UserDetails) {
        emit(LoginSuccess(result));
      } else {
        emit(LoginFailure(""));
      }
    } catch (e) {
      print(e);
      emit(LoginFailure("Login Failure"));
    }
  }
}
