import 'package:bloc/bloc.dart';
import 'package:coconut_app/auth_repo.dart';
import 'package:coconut_app/models/user.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;
  LoginCubit(this.authRepository): super(LoginInitial());

  void silentLogin() async{
    emit(LoginLoading());
    if(authRepository.silentLogin()){
      print("Success");
      emit(LoginSuccess());
    }else{
      print("Failure");
      SilentLoginFailure();
    }
  }

  void login() async {
    emit(LoginLoading());
    try {
      final result = await authRepository.login();
      if (result is UserDetails) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(""));
      }
    } catch (e) {
      print(e);
      emit(LoginFailure("Login Failure"));
    }
  }
}
