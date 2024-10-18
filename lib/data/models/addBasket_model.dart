import 'dart:convert';

class AddBasketModel {
  final int? statusCode;
  final bool? success;
  final Data? data;

  AddBasketModel({
    this.statusCode,
    this.success,
    this.data,
  });

  factory AddBasketModel.fromRawJson(String str) =>
      AddBasketModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddBasketModel.fromJson(Map<String, dynamic> json) => AddBasketModel(
        statusCode: json['statusCode'],
        success: json['success'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'success': success,
        'data': data?.toJson(),
      };
}

class Data {
  final String? id;
  final int? quantity;

  Data({
    this.id,
    this.quantity,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'],
        quantity: json['quantity'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'quantity': quantity,
      };
}
