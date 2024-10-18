import 'package:halkmarket_ecommerce/data/api_providers/deliveryType_provider.dart';
import 'package:halkmarket_ecommerce/data/models/deliveryType_model.dart';

class DeliveryRepository {
  final DeliveryTypeProvider deliveryProvider = DeliveryTypeProvider();
  Future<List<Row>> getDeliveryType() async {
    return deliveryProvider.getDeliveryType();
  }
}
