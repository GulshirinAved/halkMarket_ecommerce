import 'package:dio/dio.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';
import 'package:halkmarket_ecommerce/data/models/getOneCatalog_model.dart';

class GetOneCatalogeProvider {
  Dio dio = Dio();

  Future<Data> getOneCataloge({required String? id}) async {
    try {
      final Response response = await dio.get(Endpoints().oneCategory(id: id));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data['data'];
        final Data product = Data.fromJson(responseData);
        return product;
      } else {
        throw Exception('Failed to load catalog');
      }
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }
}
