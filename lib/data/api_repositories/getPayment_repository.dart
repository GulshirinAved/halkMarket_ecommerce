import 'package:halkmarket_ecommerce/data/api_providers/getPaymentType_provider.dart';
import 'package:halkmarket_ecommerce/data/models/payment_model.dart';

class PaymentRepository {
  final GetPaymentProvider paymentProvider = GetPaymentProvider();
  Future<List<Rows>> getPayment() async {
    return paymentProvider.getPayment();
  }
}
