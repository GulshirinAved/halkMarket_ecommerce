import 'package:dio/dio.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';
import 'package:halkmarket_ecommerce/data/models/category_model.dart';
import 'package:hive/hive.dart';

class GetAllCategoriesProvider {
  Dio dio = Dio();
  final Box langBox = Hive.box('lang');

  Future<List<Rows>> fetchAllCategories({required int page}) async {
    dio.options.headers = {
      'Accept-Language': langBox.get('lang') ?? 'tr',
      'Content-Type': 'application/json; charset=UTF-8',
    };
    try {
      final Response response = await dio.get(
        Endpoints().category(page: page),
      );
      if (response.statusCode == 200) {
        final List<dynamic> categoriesData = response.data['data']['rows'];
        final List<Rows> categories = categoriesData
            .map((categoryJson) => Rows.fromJson(categoryJson))
            .toList();

        return categories;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<int?> fetchCategoryCount({required int page}) async {
    dio.options.headers = {
      'Accept-Language': langBox.get('lang') ?? 'tr',
      'Content-Type': 'application/json; charset=UTF-8',
    };
    try {
      final Response response = await dio.get(
        Endpoints().category(page: page),
      );
      if (response.statusCode == 200) {
        final CategoryModel categoryModel =
            CategoryModel.fromJson(response.data);

        return categoryModel.data?.count;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
