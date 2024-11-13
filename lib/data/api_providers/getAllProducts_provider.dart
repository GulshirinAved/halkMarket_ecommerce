import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';
import 'package:halkmarket_ecommerce/data/models/getAllProducts_model.dart';
import 'package:hive/hive.dart';

class GetAllProductsProvider {
  Dio dio = Dio();
  final Box langBox = Hive.box('lang');
  Future<List<dynamic>> fetchAllProducts({
    int? page,
    List? categories,
    List? brands,
    List? shops,
    int? priceFrom,
    int? priceTo,
    String? ordering,
    String? search,
    bool? discount,
  }) async {
    dio.options.headers = {
      'Accept-Language': langBox.get('lang') ?? 'tr',
      'Content-Type': 'application/json; charset=UTF-8',
    };

    try {
      final Response response = await dio.post(
        Endpoints().allProducts,
        data: json.encode(
          {
            'categories': categories,
            'brands': brands,
            'shops': shops,
            'priceFrom': priceFrom,
            'priceTo': priceTo,
            'ordering': ordering,
            'search': search,
            'page': page,
            'pageSize': 10,
            'discount': discount,
            'isLiked': false,
          },
        ),
      );

      if (response.statusCode == 201) {
        final List<dynamic> products =
            response.data['data']['rows'].map((e) => Row.fromJson(e)).toList();

        return products;
      } else {
        return [];
      }
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }
}
