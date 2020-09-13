import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_details_state.dart';

class UserDetailsCubit extends Cubit<UserDetailsState> {
  UserDetailsCubit() : super(UserDetailsInitial());

  void showEditBox(){
    emit(UserDetailsShowEdit());
  }
}
