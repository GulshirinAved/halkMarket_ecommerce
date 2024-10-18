import 'package:halkmarket_ecommerce/data/api_providers/emailSubscription_provider.dart';
import 'package:halkmarket_ecommerce/data/models/brand_model.dart';

class EmailSubscriptionRepository {
  final EmailSubscriptionProvider _subscriptionProvider =
      EmailSubscriptionProvider();
  Future<List<Data>> subscribe({String? email}) async {
    return _subscriptionProvider.emailSubscribe(email: email);
  }
}
