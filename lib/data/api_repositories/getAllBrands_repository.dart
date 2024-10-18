import 'package:halkmarket_ecommerce/data/api_providers/getAllBrands_provider.dart';
import 'package:halkmarket_ecommerce/data/models/brand_model.dart';

class GetAllBrandsRepository {
  final GetAllBrandsProvider _getAllBrandsProvider = GetAllBrandsProvider();
  Future<List<Row>> fetchAllBrandsList({required int page}) async {
    return _getAllBrandsProvider.getAllBrands(page: page);
  }
}
