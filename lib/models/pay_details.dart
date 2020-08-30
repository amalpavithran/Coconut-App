import 'package:flutter/foundation.dart';

class PaymentDetails {
  final String recieverUpiID;
  final String recieverName;
  final String transactionNote;
  final double amount;

  PaymentDetails(
      {@required this.recieverUpiID,
      @required this.recieverName,
      @required this.transactionNote,
      @required this.amount});

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
        recieverUpiID: null,
        recieverName: null,
        transactionNote: null,
        amount: null);
  }
}
