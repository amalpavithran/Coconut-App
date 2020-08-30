import 'package:flutter/foundation.dart';

class PaymentDetails {
  final String upiID;
  final String recieverName;
  final String transactionRefId;
  final String transactionNote;
  final int amount;

  PaymentDetails(
      {@required this.upiID,
      @required this.recieverName,
      @required this.transactionRefId,
      @required this.transactionNote,
      @required this.amount});

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
        upiID: null,
        recieverName: null,
        transactionRefId: null,
        transactionNote: null,
        amount: null);
  }
}
