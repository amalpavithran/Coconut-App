import 'package:bloc/bloc.dart';
import 'package:coconut_app/auth_repo.dart';
import 'package:coconut_app/group_repo.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GroupRepository groupRepository;
  final AuthRepository authRepository;
  HomeCubit(this.groupRepository, this.authRepository) : super(HomeInitial());
  void joinGroupInit(){
    emit(ShowJoinGroup());
  }
  void createGroupInit(){
    emit(ShowCreateGroup());
  }
  void reset(){
    emit(HomeInitial());
  }
  void logout(){
    authRepository.logout();
    emit(Logout());
  }

  void joinGroup(String groupId){
    emit(JoinGroupLoading());
    try{
      groupRepository.joinGroup(groupId);
      emit(JoinGroupSuccess());
    }catch(e){
      print(e);
      emit(HomeFailure(e.toString()));
    }
  }
  void createGroup(String groupName,String description){
    emit(JoinGroupLoading());
    try{
      groupRepository.createGroup(groupName, description);
      emit(JoinGroupSuccess());
    }catch(e){
      print(e);
      emit(HomeFailure(e.toString()));
    }
  }
}
