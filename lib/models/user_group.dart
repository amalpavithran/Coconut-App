import 'pay_details.dart';
import 'transaction.dart';
import 'user.dart';

class UserGroup {
  final String name;
  final String groupId;
  bool ended = false;

  final List<Map<UserDetails, double>> groupInfo;
  final List<Transaction> transactions;
  final List<PaymentDetails> paymentDetails;
  UserGroup(this.name, this.groupId, this.groupInfo, this.transactions,
      this.paymentDetails, this.ended);
}
