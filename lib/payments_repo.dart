import 'package:coconut_app/models/user.dart';

abstract class PaymentsRepository {
  Future<bool> MakePayment(User from, User to);
}

class PaymentsRepositoryImpl implements PaymentsRepository {
  @override
  Future<bool> MakePayment(User from, User to) {
    // TODO: implement MakePayment
    throw UnimplementedError();
  }
}
