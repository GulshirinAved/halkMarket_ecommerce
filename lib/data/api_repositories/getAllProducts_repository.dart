import 'package:halkmarket_ecommerce/data/api_providers/getAllProducts_provider.dart';

class GetAllProductsRepository {
  final GetAllProductsProvider _getAllProductsProvider =
      GetAllProductsProvider();
  Future<List<dynamic>> fetchAllProductList({
    int? page,
    List? categories,
    List? brands,
    List? shops,
    int? priceFrom,
    int? priceTo,
    String? ordering,
    String? search,
    bool? discount,
  }) async {
    return _getAllProductsProvider.fetchAllProducts(
      page: page,
      categories: categories ?? [],
      brands: brands ?? [],
      shops: shops ?? [],
      priceFrom: priceFrom,
      priceTo: priceTo,
      ordering: ordering ?? 'popular',
      search: search ?? '',
      discount: discount ?? false,
    );
  }
}
