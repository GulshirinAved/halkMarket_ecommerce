import 'package:dio/dio.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';
import 'package:halkmarket_ecommerce/data/models/getOneProduct_model.dart';

class GetOneProductProvider {
  Dio dio = Dio();

  Future<Data> getOneProduct(String? id) async {
    try {
      final Response response =
          await dio.get(Endpoints().getOneProduct(id: id));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data['data'];
        final Data product = Data.fromJson(responseData);
        return product;
      } else {
        throw Exception('Failed to load product');
      }
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }
}
