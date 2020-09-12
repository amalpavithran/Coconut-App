import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  GroupCubit() : super(GroupInitial());
}
