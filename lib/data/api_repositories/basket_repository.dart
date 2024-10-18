import 'package:halkmarket_ecommerce/data/api_providers/basket_provider.dart';
import 'package:halkmarket_ecommerce/data/models/getOneOrderHis_model.dart';
import 'package:halkmarket_ecommerce/data/models/orderHistory_model.dart';

class BasketRepository {
  final BasketProvider basketProvider = BasketProvider();
  Future<bool> addBasket({
    required String? id,
    required String? productId,
    required int quantity,
  }) async {
    return basketProvider.addBasket(
      id: id,
      productId: productId,
      quantity: quantity,
    );
  }

  Future<bool> removeProduct({final String? id}) {
    return basketProvider.removeProduct(id: id);
  }

  Future<bool> removeAllProduct() {
    return basketProvider.removeAllBasket();
  }

  Future<List<Row>> getHistory() async {
    return basketProvider.getHistory();
  }

  Future<Datum?> getOneHistory({required String id}) async {
    return basketProvider.getOneOrderHistory(id: id);
  }

  Future<bool?> cancelOrder({required String id}) async {
    return basketProvider.cancelOrder(id: id);
  }
}
