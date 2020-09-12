import 'package:coconut_app/models/transaction.dart';
import 'package:coconut_app/models/user.dart';

class UserGroup {
  final String name;
  final String groupId;
  bool ended = false;

  final List<Map<UserDetails, double>> groupInfo;
  final List<Transaction> transactions;
  UserGroup(this.name, this.groupId, this.groupInfo, this.transactions);
}
