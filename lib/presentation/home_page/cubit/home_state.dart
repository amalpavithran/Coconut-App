part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeFailure extends HomeState {
  final message;

  HomeFailure(this.message);
}

class ShowJoinGroup extends HomeState {}

class ShowCreateGroup extends HomeState {}

class JoinGroupLoading extends HomeState {}

class JoinGroupSuccess extends HomeState {}

class HomeCreateGroupSuccess extends HomeState {}

class HomeCreateGroupFailure extends HomeState {}
