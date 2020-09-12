import 'package:cloud_functions/cloud_functions.dart';
import 'package:coconut_app/models/pay_details.dart';
import 'package:coconut_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:upi_india/upi_india.dart';

abstract class PaymentRepository {
  Future<Map<UserDetails, String>> initiatePayment(PaymentDetails details,
      String groupId); // Returns a response, Success, Failure+error
  Future<Map<UserDetails, String>> endTrip(String groupid);
}

class PaymentRepositoryImpl implements PaymentRepository {
  @override
  Future<Map<UserDetails, String>> initiatePayment(
      PaymentDetails details, String groupId) async {
    UpiIndia _upiIndia = UpiIndia();
    Map<String, String> response = {};
    response["Status"] = "Loading";
    return _upiIndia
        .startTransaction(
            app: UpiApp.GooglePay,
            receiverUpiId: details.recieverUpiID,
            receiverName: details.recieverName,
            transactionNote: details.transactionNote,
            amount: details.amount)
        .then((_upiResponse) async {
      print(_upiResponse);
      if (_upiResponse.error != null) {
        response["Status"] = "Failure";
        switch (_upiResponse.error) {
          case UpiError.APP_NOT_INSTALLED:
            response["Report"] = "Requested app not installed on device";
            break;
          case UpiError.INVALID_PARAMETERS:
            response["Report"] = "Requested app cannot handle the transaction";
            break;
          case UpiError.NULL_RESPONSE:
            response["Report"] = "Requested app didn't returned any response";
            break;
          case UpiError.USER_CANCELLED:
            response["Report"] = "You cancelled the transaction";
            break;
        }
      } else {
        response["Status"] = "Success";
        Map data = {
          "data": {
            "groupId": groupId,
            "transaction": {
              "spender": FirebaseAuth.instance.currentUser.uid,
              "amount": details.amount
            }
          }
        };
        final HttpsCallable callable = CloudFunctions.instance
            .getHttpsCallable(functionName: "addTransaction");
        final HttpsCallableResult fnresponse =
            await callable.call(data).catchError((e) {
          response["Status"] = "Failure";
          response["Report"] = e;
        });
      }
    });
  }

  @override
  Future<Map<UserDetails, String>> endTrip(String groupid) {
    // TODO: implement endTrip
    throw UnimplementedError();
  }
}
