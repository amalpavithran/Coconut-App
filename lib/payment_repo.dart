import 'package:coconut_app/models/pay_details.dart';
import 'package:upi_india/upi_india.dart';

abstract class PaymentRepository {
  Future<String> initiatePayment(
      PaymentDetails details); // Returns a response, Success, Failure+error
}

class Payment implements PaymentRepository {
  @override
  Future<String> initiatePayment(PaymentDetails details) {
    UpiIndia _upiIndia = UpiIndia();
  }
}
