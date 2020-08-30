import 'package:bloc/bloc.dart';
import 'package:coconut_app/auth_repo.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;
  LoginCubit(this.authRepository) : super(LoginInitial());

  void login(String phoneNumber, String password) async {
    emit(LoginLoading());
    try {
      final result = await authRepository.login();
      emit(LoginSuccess());
    } catch (e) {
      print(e);
      LoginFailure("Login Failure");
    }
  }
}
