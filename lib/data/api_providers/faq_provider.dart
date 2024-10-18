import 'package:dio/dio.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';
import 'package:halkmarket_ecommerce/data/models/faq_model.dart';

class FaqProvider {
  Dio dio = Dio();
  Future<List<Row>> getFaq() async {
    try {
      final Response response = await dio.get(
        Endpoints().getFaq,
      );
      if (response.statusCode == 200) {
        final List<dynamic> faqData = response.data['data']['rows'];
        final List<Row> faqList = faqData.map((e) => Row.fromJson(e)).toList();
        return faqList;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
