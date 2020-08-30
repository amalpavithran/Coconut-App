import 'package:coconut_app/models/pay_details.dart';
import 'package:upi_india/upi_india.dart';

abstract class PaymentRepository {
  Future<Map<String, String>> initiatePayment(
      PaymentDetails details); // Returns a response, Success, Failure+error
}

class Payment implements PaymentRepository {
  @override
  // ignore: missing_return
  Future<Map<String, String>> initiatePayment(PaymentDetails details) {
    UpiIndia _upiIndia = UpiIndia();
    Map<String, String> response;

    _upiIndia
        .startTransaction(
            app: UpiApp.GooglePay,
            receiverUpiId: details.recieverUpiID,
            receiverName: details.recieverName,
            transactionNote: details.transactionNote,
            amount: details.amount)
        .then((_upiResponse) {
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
      } else
        response["Status"] = "Success";
      return response;
    });
  }
}
