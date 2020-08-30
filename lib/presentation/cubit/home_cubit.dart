import 'package:bloc/bloc.dart';
import 'package:coconut_app/group_repo.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GroupRepository groupRepository;
  HomeCubit(this.groupRepository) : super(HomeInitial());
  void joinGroupInit(){
    emit(ShowJoinGroup());
  }
  void createGroupInit(){
    emit(ShowCreateGroup());
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
