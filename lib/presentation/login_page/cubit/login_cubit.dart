import 'package:bloc/bloc.dart';
import 'package:coconut_app/auth_repo.dart';
import 'package:coconut_app/models/user.dart';
import 'package:coconut_app/user_repo.dart';
import 'package:meta/meta.dart';

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
