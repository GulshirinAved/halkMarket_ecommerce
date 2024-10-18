import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:halkmarket_ecommerce/data/api_providers/auth_provider.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';
import 'package:halkmarket_ecommerce/data/models/adress_model.dart';

class UserAdressProvider {
  final Dio dio = Dio();
  Future<Data> addAdress({
    required String id,
    required String address,
    required String apartment,
    required String entrance,
    required String floor,
    required String comment,
    required String latitude,
    required String longitude,
  }) async {
    final headers = {
      'Authorization': 'Bearer ${AuthProvider().getAccessToken()}',
      'Cookie': 'i18n_redirected=ru',
    };
    final Response response = await dio.post(
      Endpoints().upsertUserAddress,
      data: json.encode({
        'id': '',
        'address': address,
        'apartment': apartment,
        'entrance': entrance,
        'floor': floor,
        'comment': comment,
        'latitude': latitude,
        'longitude': longitude,
      }),
      options: Options(
        headers: headers,
      ),
    );
    try {
      if (response.statusCode == 201) {
        log('it is location add ${"""data: json.encode({
        'id': '',
        'address': $address,
        'apartment': $apartment,
        'entrance': $entrance,
        'floor': $floor,
        'comment': $comment,
        'latitude': $latitude,
        'longitude': $longitude,
      })"""},');
        final Map<String, dynamic> userData = response.data['data'];
        final Data userAdress = Data.fromJson(userData);
        return userAdress;
      } else {
        return Data();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Data> removeAddress({required String id}) async {
    final headers = {
      'Authorization': 'Bearer ${AuthProvider().getAccessToken()}',
      'Cookie': 'i18n_redirected=ru',
    };
    final Response response = await dio.post(
      Endpoints().removeUserAddress(id: id),
      options: Options(headers: headers),
    );
    try {
      if (response.statusCode == 201) {
        final Map<String, dynamic> userData = response.data['data'];
        final Data userAdress = Data.fromJson(userData);
        return userAdress;
      } else {
        return Data();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
