import 'package:bloc/bloc.dart';
import 'package:coconut_app/models/user.dart';
import 'package:coconut_app/user_repo.dart';
import 'package:meta/meta.dart';

import '../../../injection_container.dart';

part 'account_state.dart';

const INVALID_ID = "Enter a valid UPI ID";

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());

  void updateUpi(String upiId) async {
    if (upiId.isNotEmpty) {
      emit(AccountInitial());
      await sl<UserRepository>().updateUPI(upiId);
    } else {
      emit(AccountFailure(INVALID_ID));
    }
  }
}
