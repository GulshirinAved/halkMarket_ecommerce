import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';
import 'package:halkmarket_ecommerce/data/models/updateUserData_model.dart';
import 'package:hive/hive.dart';

class AuthProvider {
  Dio dio = Dio();
  final Box authBox = Hive.box('auth');
  final Box langBox = Hive.box('lang');

  AuthProvider() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final accessToken = getAccessToken();
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            final refreshToken = getRefreshToken();
            if (refreshToken != null) {
              final success = await _refreshToken(refreshToken);
              if (success) {
                final retryOptions = e.requestOptions;
                retryOptions.headers['Authorization'] =
                    'Bearer ${getAccessToken()}';
                final response = await dio.request(
                  retryOptions.path,
                  options: Options(
                    method: retryOptions.method,
                    headers: retryOptions.headers,
                  ),
                  data: retryOptions.data,
                  queryParameters: retryOptions.queryParameters,
                );
                return handler.resolve(response);
              }
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<bool> _refreshToken(String refreshToken) async {
    try {
      final Response response = await dio.post(
        Endpoints().refreshToken(refresh: refreshToken),
        data: json.encode({'refresh': refreshToken}),
      );
      if (response.statusCode == 200) {
        final newAccessToken = response.data['access'];
        final newRefreshToken = response.data['refresh'];
        if (newAccessToken != null && newRefreshToken != null) {
          await authBox.put('accessToken', newAccessToken);
          await authBox.put('refreshToken', newRefreshToken);
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<int?> register({
    String? phone,
    String? name,
    String? address,
    String? birthday,
    String? email,
    String? gender,
    String? password,
  }) async {
    try {
      final Response response = await dio.post(
        Endpoints().signUp,
        data: json.encode({
          'phone': phone ?? '+99365671855',
          'name': name ?? 'Gulshirin',
          'address': address ?? 'some text data',
          'birthday': birthday ?? '1991-01-01',
          'email': email,
          'gender': gender ?? 'male',
          'password': password ?? '',
        }),
      );
      log(response.data['statusCode'].runtimeType.toString());
      return response.data['statusCode'];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<int?> otp({String? phone, int? otp}) async {
    try {
      final Response response = await dio.post(
        Endpoints().otp,
        data: json.encode({'phone': phone, 'otp': otp}),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic>? data =
            response.data['data'] as Map<String, dynamic>?;
        final Map<String, dynamic>? user =
            data?['user'] as Map<String, dynamic>?;
        final Map<String, dynamic>? token =
            data?['token'] as Map<String, dynamic>?;

        if (user != null && token != null) {
          final accessToken = token['access'];
          final refreshToken = token['refresh'];
          final userId = user['id'];

          if (accessToken != null && refreshToken != null) {
            await authBox.put('accessToken', accessToken);
            await authBox.put('refreshToken', refreshToken);
            await authBox.put('userId', userId);
          }
        } else {
          throw Exception('Invalid response data. Missing user or token.');
        }
        log(response.statusCode.toString());

        return response.data['statusCode'] as int?;
      } else {
        throw Exception(
          'OTP request failed with status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      log(e.toString());

      throw Exception('Error during OTP request: ${e.toString()}');
    }
  }

  Future<int?> signIn({String? phone, String? password}) async {
    try {
      final Response response = await dio.post(
        Endpoints().signIn,
        data: json.encode({'phone': phone, 'password': password}),
      );

      if (response.statusCode == 201) {
        final data = response.data['data'];
        if (data != null) {
          final accessToken = data['token']?['access'];
          final refreshToken = data['token']?['refresh'];
          final userId = data['user']?['id'];

          if (accessToken != null && refreshToken != null) {
            await authBox.put('accessToken', accessToken);
            await authBox.put('refreshToken', refreshToken);
            await authBox.put('userId', userId);
          }
        }
      }

      final statusCode = response.data['statusCode'];

      return int.tryParse(statusCode.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Data?> changePass({String? oldPass, String? newPass}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${getAccessToken()}',
      'Cookie': 'i18n_redirected=tk',
    };

    try {
      final responseData = {'oldPassword': oldPass, 'newPassword': newPass};
      final Response response = await dio.post(
        Endpoints().changePass,
        data: json.encode(responseData),
        options: Options(headers: headers),
      );

      if (response.data['statusCode'] == 200) {
        final data = response.data['data'];
        if (data != null) {
          final accessToken = data['token']?['access'];
          final refreshToken = data['token']?['refresh'];
          final userId = data['user']?['id'];

          if (accessToken != null && refreshToken != null) {
            await authBox.put('accessToken', accessToken);
            await authBox.put('refreshToken', refreshToken);
            await authBox.put('userId', userId);
          }
        }
        return Data.fromJson(data);
      } else if (response.data['statusCode'] == 401) {
        final success = await _refreshToken(getRefreshToken()!);
        if (success) {
          headers['Authorization'] = 'Bearer ${getAccessToken()}';
          final retryResponse = await dio.post(
            Endpoints().changePass,
            data: json.encode(responseData),
            options: Options(headers: headers),
          );
          if (retryResponse.data['statusCode'] == 200) {
            final data = retryResponse.data['data'];
            if (data != null) {
              final accessToken = data['token']?['access'];
              final refreshToken = data['token']?['refresh'];
              final userId = data['user']?['id'];

              if (accessToken != null && refreshToken != null) {
                await authBox.put('accessToken', accessToken);
                await authBox.put('refreshToken', refreshToken);
                await authBox.put('userId', userId);
              }
            }
            return Data.fromJson(data);
          } else {
            throw Exception('Failed to change password after refreshing token');
          }
        } else {
          throw Exception('Failed to refresh token');
        }
      } else {
        throw Exception('Failed to change password');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  Future<int?> forgetPass({String? phone, String? password}) async {
    try {
      final Response response = await dio.post(
        Endpoints().forgetPass,
        data: json.encode({'phone': phone, 'password': password}),
      );
      final int statusCode = response.data['statusCode'];
      return statusCode;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Data> updateUserData({
    required String? name,
    required String? email,
    required String? phone,
    required String? birthday,
    required String? gender,
  }) async {
    try {
      final Map<String, dynamic> requestData = {
        'name': name,
        'email': email,
        'birthday': birthday,
        'gender': gender,
      };

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${getAccessToken()}',
        'Cookie': 'i18n_redirected=tk',
      };

      final Response response = await dio.post(
        Endpoints().updateUserData,
        data: json.encode(requestData),
        options: Options(headers: headers),
      );

      if (response.statusCode == 201) {
        final data = response.data['data'];

        return Data.fromJson(data);
      } else if (response.statusCode == 401) {
        final success = await _refreshToken(getRefreshToken()!);
        if (success) {
          headers['Authorization'] = 'Bearer ${getAccessToken()}';
          final retryResponse = await dio.post(
            Endpoints().updateUserData,
            data: json.encode(requestData),
            options: Options(headers: headers),
          );
          if (retryResponse.statusCode == 201) {
            final data = retryResponse.data['data'];

            return Data.fromJson(data);
          } else {
            throw Exception('Failed to update user data after token refresh');
          }
        } else {
          throw Exception('Failed to refresh token');
        }
      } else {
        throw Exception('Failed to update user data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future removeAccount() async {
    await authBox.clear();
    return null;
  }

  String? getAccessToken() {
    return authBox.get('accessToken');
  }

  String? getRefreshToken() {
    return authBox.get('refresh');
  }

  String? getUserId() {
    return authBox.get('userId');
  }

  Future<Data> getUserProfile() async {
    dio.options.headers = {
      'Accept-Language': langBox.get('lang') ?? 'tr',
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${getAccessToken()}',
    };
    try {
      final Response response = await dio.get(Endpoints().userProfile);
      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = response.data['data'];
        final Data userList = Data.fromJson(userData);
        return userList;
      } else {
        return Data();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String?>? getDeviceId() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final build = await deviceInfoPlugin.androidInfo;
        return build.id;
      } else if (Platform.isIOS) {
        final data = await deviceInfoPlugin.iosInfo;
        return data.identifierForVendor;
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }
}
