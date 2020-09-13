import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repos/auth_repo.dart';
import '../../repos/group_repo.dart';
import '../../repos/user_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GroupRepository groupRepository;
  final AuthRepository authRepository;
  final UserRepository userRepository;
  HomeCubit(this.groupRepository, this.authRepository, this.userRepository) : super(HomeInitial());
  void joinGroupInit() {
    emit(ShowJoinGroup());
  }

  void createGroupInit() {
    emit(ShowCreateGroup());
  }

  void reset() {
    
    emit(HomeInitial());
  }

  void logout() {
    try {
      authRepository.logout();
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
    emit(Logout());
  }

  void joinGroup(String groupId) {
    emit(JoinGroupLoading());
    try {
      groupRepository.joinGroup(groupId);
      emit(JoinGroupSuccess());
    } catch (e) {
      print(e);
      emit(HomeFailure(e.toString()));
    }
  }

  void createGroup(String groupName, String description) {
    emit(JoinGroupLoading());
    try {
      groupRepository.createGroup(groupName, description);
      emit(JoinGroupSuccess());
    } catch (e) {
      print(e);
      emit(HomeFailure(e.toString()));
    }
  }
}
