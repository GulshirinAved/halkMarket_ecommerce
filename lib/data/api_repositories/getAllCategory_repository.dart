import 'package:halkmarket_ecommerce/data/api_providers/getAllCategory_provider.dart';
import 'package:halkmarket_ecommerce/data/models/category_model.dart';

class GetAllCategoriesRepository {
  final GetAllCategoriesProvider _getAllCategoriesProvider =
      GetAllCategoriesProvider();

  Future<List<Rows>> fetchCategoryProductList({
    required int page,
  }) async {
    return _getAllCategoriesProvider.fetchAllCategories(
      page: page,
    );
  }

  Future<int?> fetchCountCategory({
    required int page,
  }) async {
    return _getAllCategoriesProvider.fetchCategoryCount(page: page);
  }
}
