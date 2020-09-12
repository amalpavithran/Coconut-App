import 'package:bloc/bloc.dart';
import 'package:coconut_app/auth_repo.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;
  LoginCubit(this.authRepository): super(LoginInitial());

  void silentLogin() async{
    emit(LoginLoading());
    if(await authRepository.silentLogin()){
      emit(LoginSuccess());
    }else{
      SilentLoginFailure();
    }
  }

  void login() async {
    emit(LoginLoading());
    try {
      final result = await authRepository.login();
      if (result == "Success") {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(result));
      }
    } catch (e) {
      print(e);
      emit(LoginFailure("Login Failure"));
    }
  }
}
