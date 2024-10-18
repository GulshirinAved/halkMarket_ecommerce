import 'package:dio/dio.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';
import 'package:halkmarket_ecommerce/data/models/payment_model.dart';
import 'package:hive/hive.dart';

class GetPaymentProvider {
  Dio dio = Dio();
  final Box langBox = Hive.box('lang');

  Future<List<Rows>> getPayment() async {
    try {
      final Response response = await dio.get(Endpoints().paymentType);
      dio.options.headers = {
        'Accept-Language': langBox.get('lang') ?? 'tr',
        'Content-Type': 'application/json; charset=UTF-8',
      };
      if (response.statusCode == 200) {
        final List<dynamic> paymentData = response.data['data']['rows'];
        final List<Rows> paymentTypes = paymentData
            .map(
              (e) => Rows.fromJson(e),
            )
            .toList();
        return paymentTypes;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
