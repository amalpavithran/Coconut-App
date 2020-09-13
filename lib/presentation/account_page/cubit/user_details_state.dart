part of 'user_details_cubit.dart';

@immutable
abstract class UserDetailsState {}

class UserDetailsInitial extends UserDetailsState {}

class UserDetailsShowEdit extends UserDetailsState {}

class UserDetailsLoading extends UserDetailsState {}

class UserDetailsSuccess extends UserDetailsState {
  final String message;

  UserDetailsSuccess(this.message);
}

class UserDetailsFailure extends UserDetailsState {
  final String message;

  UserDetailsFailure(this.message);
}
