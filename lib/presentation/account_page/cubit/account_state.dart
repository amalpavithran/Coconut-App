part of 'account_cubit.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountEditUpi extends AccountState {}

class AccountLoading extends AccountState {}

class AccountFailure extends AccountState {
  final String message;

  AccountFailure(this.message);
}
