import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';

class CreateFeedbackProvider {
  Dio dio = Dio();
  Future<bool?> createFeedback({
    final String? name,
    final String? message,
    final String? phone,
    final String? email,
  }) async {
    try {
      final Response response = await dio.post(
        Endpoints().createFeedback,
        data: json.encode({
          'name': name,
          'message': message,
          'phone': phone,
          'email': null,
        }),
      );
      log(response.statusCode.toString());
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
