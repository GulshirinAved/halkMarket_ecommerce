import 'package:dio/dio.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';
import 'package:halkmarket_ecommerce/data/models/brand_model.dart';

class GetAllBrandsProvider {
  Dio dio = Dio();
  Future<List<Row>> getAllBrands({required int page}) async {
    try {
      final Response response = await dio.get(Endpoints().allBrands(
        page: page,
      ));
      if (response.statusCode == 200) {
        final List<dynamic> brandsData = response.data['data']['rows'];
        final List<Row> brands = brandsData
            .map(
              (e) => Row.fromJson(e),
            )
            .toList();
        return brands;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
