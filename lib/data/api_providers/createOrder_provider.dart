import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:halkmarket_ecommerce/data/api_providers/auth_provider.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';

class CreateOrderProvider {
  Dio dio = Dio();
  Future<bool> createCartProduct(Map<String, dynamic> postData) async {
    final headers = {
      'Authorization': 'Bearer ${AuthProvider().getAccessToken()}',
      'Cookie': 'i18n_redirected=ru',
    };
    try {
      final Response response = await dio.post(
        Endpoints().createOrder,
        data: json.encode(postData),
        options: Options(headers: headers),
      );
      if (response.data['statusCode'] == 200) {
        return true;
      }

      return false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
