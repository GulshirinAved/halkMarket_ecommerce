import 'package:dio/dio.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';
import 'package:halkmarket_ecommerce/data/models/brand_model.dart';

class EmailSubscriptionProvider {
  Dio dio = Dio();
  Future<List<Data>> emailSubscribe({final String? email}) async {
    try {
      final Response response =
          await dio.post(Endpoints().emailSubscribe(email: email));
      if (response.statusCode == 201) {
        final List<Data> subscription =
            response.data['data'].map((e) => Data.fromJson(e)).toList();
        return subscription;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
