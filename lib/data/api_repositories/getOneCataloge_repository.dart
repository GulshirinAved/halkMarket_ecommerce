import 'package:halkmarket_ecommerce/data/api_providers/getOneCataloge_provider.dart';
import 'package:halkmarket_ecommerce/data/models/getOneCatalog_model.dart';

class GetOneCatalogeRepository {
  final GetOneCatalogeProvider _getOneCatalogeProvider =
      GetOneCatalogeProvider();
  Future<Data> getOneCataloge(
    final String? id,
  ) async {
    return _getOneCatalogeProvider.getOneCataloge(id: id);
  }
}
