import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';
import 'package:halkmarket_ecommerce/data/models/category_model.dart';
import 'package:halkmarket_ecommerce/data/models/getHome_model.dart.dart';
import 'package:hive/hive.dart';

class HomeProvider {
  Dio dio = Dio();
  final Box langBox = Hive.box('lang');
  final Box homeBox = Hive.box('homeProducts');
  final Box homeDataBox = Hive.box('homeData');
  final Box homePopularCategoryBox = Hive.box('popularCategory');

  //banner
  Future<List<dynamic>> fetchAllHomeBanner() async {
    try {
      final Response response = await dio.get(Endpoints().home);
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        final List<dynamic> homeTypeData = response.data['data'];
        final List<dynamic> bannerList = homeTypeData
            .where((e) => e['type'] == 'banners')
            .map((bannersJson) {
              final List<dynamic> bannerRows = bannersJson['rows']
                  .map((rowJson) => Row.fromJson(rowJson))
                  .toList();
              return bannerRows;
            })
            .expand((i) => i)
            .toList();
        return bannerList;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //small category
  Future<List<Rows>> fetchSmallCategory() async {
    dio.options.headers = {
      'Accept-Language': langBox.get('lang') ?? 'tr',
      'Content-Type': 'application/json; charset=UTF-8',
    };
    try {
      final Response response = await dio.get(Endpoints().allCategory);
      log(response.statusCode.toString());

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

  //popular category
  Future<List<dynamic>> fetchPopularCategory() async {
    try {
      if (homePopularCategoryBox.isEmpty) {
        final Response response = await dio.get(Endpoints().home);
        log(response.statusCode.toString());

        if (response.statusCode == 200) {
          final List<dynamic> homeTypeData = response.data['data'];
          final List<dynamic> popularCategoryList = homeTypeData
              .where((e) => e['type'] == 'popularCategory')
              .map((popularCategoryJson) {
                final List<dynamic> popularCategoryRow =
                    popularCategoryJson['rows']
                        .map((rowJson) => Row.fromJson(rowJson))
                        .toList();
                return popularCategoryRow;
              })
              .expand((i) => i)
              .toList();

          final List<dynamic> serializedPopularCategoryList =
              popularCategoryList.map((e) => e.toJson()).toList();
          await homePopularCategoryBox.addAll(serializedPopularCategoryList);

          return popularCategoryList;
        } else {
          return [];
        }
      } else {
        final List<dynamic> cachedPopularCategoryList =
            homePopularCategoryBox.values.map((e) => Row.fromJson(e)).toList();
        return cachedPopularCategoryList;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //type=='products' from this need get count and category name
  Future<List<Datum>> fetchAllHomeData() async {
    try {
      if (homeDataBox.isEmpty) {
        final Response response = await dio.get(Endpoints().home);
        log(response.statusCode.toString());

        if (response.statusCode == 200) {
          final List<dynamic> homeData = response.data['data']
              .where((item) => item['type'] == 'products')
              .toList();
          final List<Datum> homeProducts = homeData
              .map<Datum>(
                (productData) =>
                    Datum.fromJson(productData as Map<String, dynamic>),
              )
              .toList();
          final List<Map<String, dynamic>> serializedHomeProductsList =
              homeProducts.map((e) => e.toJson()).toList();
          await homeDataBox.addAll(serializedHomeProductsList);
          final List<Datum> cachedHomeProductsList = homeDataBox.values
              .map<Datum>(
                (e) => Datum.fromJson(e as Map<String, dynamic>),
              )
              .toList();

          return cachedHomeProductsList;
        } else {
          return [];
        }
      } else {
        final List<Datum> cachedHomeProductsList = homeDataBox.values
            .map<Datum>(
              (e) => Datum.fromJson(e as Map<String, dynamic>),
            )
            .toList();
        return cachedHomeProductsList;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  ///type=='product' from this need get products
  Future<List<List<Row>>> fetchAllHomeProducts() async {
    try {
      if (homeBox.isEmpty) {
        final Response response = await dio.get(Endpoints().home);
        log(response.statusCode.toString());

        if (response.statusCode == 200) {
          final List<dynamic> homeData = response.data['data']
              .where((item) => item['type'] == 'products')
              .toList();
          final List<List<Row>> listOfProductLists = [];
          for (var productData in homeData) {
            final List<dynamic> rows = productData['rows'];
            final List<Row> productList = rows
                .map<Row>((row) => Row.fromJson(row as Map<String, dynamic>))
                .toList();
            listOfProductLists.add(productList);
          }
          for (var productList in listOfProductLists) {
            final List<Map<String, dynamic>> serializedProductList =
                productList.map((e) => e.toJson()).toList();
            await homeBox.add(serializedProductList);
          }
          return listOfProductLists;
        } else {
          return [];
        }
      } else {
        final List<List<Row>> cachedListOfProductLists = [];
        for (var serializedProductList in homeBox.values) {
          final List<Row> productList = (serializedProductList as List)
              .map<Row>((e) => Row.fromJson(e as Map<String, dynamic>))
              .toList();
          cachedListOfProductLists.add(productList);
        }

        return cachedListOfProductLists;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
