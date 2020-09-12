import 'package:cloud_functions/cloud_functions.dart';
import 'package:coconut_app/models/pay_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:upi_india/upi_india.dart';

abstract class PaymentRepository {
  Future<String> initiatePayment(PaymentDetails details,
      String groupId); // Returns a response, Success, Failure+error
  Future<String> endTrip(String groupid);
}

class PaymentRepositoryImpl implements PaymentRepository {
  @override
  Future<String> initiatePayment(PaymentDetails details, String groupId) async {
    UpiIndia _upiIndia = UpiIndia();
    String response = "Success";
    _upiIndia
        .startTransaction(
            app: UpiApp.GooglePay,
            receiverUpiId: details.recieverUpiID,
            receiverName: details.recieverName,
            transactionNote: details.transactionNote,
            amount: details.amount)
        .then((_upiResponse) async {
      print(_upiResponse);
      if (_upiResponse.error != null) {
        switch (_upiResponse.error) {
          case UpiError.APP_NOT_INSTALLED:
            response = "Requested app not installed on device";
            break;
          case UpiError.INVALID_PARAMETERS:
            response = "Requested app cannot handle the transaction";
            break;
          case UpiError.NULL_RESPONSE:
            response = "Requested app didn't returned any response";
            break;
          case UpiError.USER_CANCELLED:
            response = "You cancelled the transaction";
            break;
        }
      } else {
        Map data = {
          "groupId": groupId,
          "transaction": {
            "spender": FirebaseAuth.instance.currentUser.uid,
            "amount": details.amount
          }
        };
        final HttpsCallable callable = CloudFunctions.instance
            .getHttpsCallable(functionName: "addTransaction");
        await callable.call(data).catchError((e) {
          response = e;
        });
      }
    });
    return response;
  }

  @override
  Future<String> endTrip(String groupid) async {
    Map<String, String> data = {
      "groupId": groupid,
    };
    final HttpsCallable callable =
        CloudFunctions.instance.getHttpsCallable(functionName: "endTrip");
    await callable.call(data).catchError((e) {
      return e;
    });
    return "Success";
  }
}
