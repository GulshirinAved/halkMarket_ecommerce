import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';

class CreateOrderProvider {
  Dio dio = Dio();
  Future<bool> createCartProduct(Map<String, dynamic> postData) async {
    final headers = {
      'Content-Type': 'application/json',
      'Cookie': 'i18n_redirected=ru',
    };
    try {
      final Response response = await dio.post(
        Endpoints().createOrder,
        data: json.encode(postData),
        options: Options(headers: headers),
      );
      log('Response status: ${response.statusCode}');
      log('Response message: ${response.statusMessage}');
      log('Response data: ${response.data}');
      log('Request data: $postData');
      if (response.data['statusCode'] == 200) {
        return true;
      }

      return false;
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}
