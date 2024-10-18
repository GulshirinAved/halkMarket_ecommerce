import 'package:halkmarket_ecommerce/data/api_providers/createOrder_provider.dart';

class CreateOrderRepository {
  final CreateOrderProvider _createOrderProvider = CreateOrderProvider();
  Future<bool> createOrder({required Map<String, dynamic> postData}) async {
    return _createOrderProvider.createCartProduct(postData);
  }
}
