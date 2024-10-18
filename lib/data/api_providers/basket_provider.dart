import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:halkmarket_ecommerce/data/api_providers/auth_provider.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';
import 'package:halkmarket_ecommerce/data/models/getOneOrderHis_model.dart';
import 'package:halkmarket_ecommerce/data/models/orderHistory_model.dart';

class BasketProvider {
  Dio dio = Dio();
  Future<bool> addBasket({
    required String? id,
    required String? productId,
    required int? quantity,
  }) async {
    try {
      final headers = {
        'Authorization': 'Bearer ${AuthProvider().getAccessToken()}',
        'Cookie': 'i18n_redirected=ru',
      };
      final Response response = await dio.post(
        Endpoints().addBasket,
        data: json
            .encode({'id': id, 'productId': productId, 'quantity': quantity}),
        options: Options(headers: headers),
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> removeProduct({final String? id}) async {
    try {
      final headers = {
        'Authorization': 'Bearer ${AuthProvider().getAccessToken()}',
        'Cookie': 'i18n_redirected=ru',
      };
      final Response response = await dio.post(
        Endpoints().removeBasket(id: id),
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> removeAllBasket() async {
    try {
      final headers = {
        'Authorization': 'Bearer ${AuthProvider().getAccessToken()}',
        'Cookie': 'i18n_redirected=ru',
      };
      final Response response = await dio.post(
        Endpoints().removeAllBasket,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 201) {
        return response.data['data']['deleted'];
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Row>> getHistory() async {
    try {
      final headers = {
        'Authorization': 'Bearer ${AuthProvider().getAccessToken()}',
        'Cookie': 'i18n_redirected=ru',
      };
      final Response response = await dio.get(
        Endpoints().orderHistory,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        final List<dynamic> orderData = response.data['data']['rows'];
        final List<Row> orderList = orderData
            .map(
              (e) => Row.fromJson(e),
            )
            .toList();
        log('it is egget hisory $orderList');
        return orderList;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Datum?> getOneOrderHistory({required String id}) async {
    final headers = {
      'Authorization': 'Bearer ${AuthProvider().getAccessToken()}',
      'Cookie': 'i18n_redirected=ru',
    };
    try {
      final Response response = await dio.get(
        Endpoints().oneOrderHistory(id: id),
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        final Datum historyData = Datum.fromJson(response.data['data']);
        return historyData;
      } else {
        return Datum();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool?> cancelOrder({required String id}) async {
    try {
      final Response response =
          await dio.patch(Endpoints().cancelOrder(id: id));
      if (response.data['statusCode'] == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
