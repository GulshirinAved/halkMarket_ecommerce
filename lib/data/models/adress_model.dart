import 'dart:convert';

class AddressModel {
  final int? statusCode;
  final bool? success;
  final Data? data;

  AddressModel({
    this.statusCode,
    this.success,
    this.data,
  });

  factory AddressModel.fromRawJson(String str) =>
      AddressModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
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
  final String? address;
  final String? apartment;
  final String? entrance;
  final String? floor;
  final String? comment;
  final String? userId;
  final String? latitude;
  final String? longitude;
  final DateTime? createdAt;
  final dynamic deletedAt;

  Data({
    this.id,
    this.address,
    this.apartment,
    this.entrance,
    this.floor,
    this.comment,
    this.userId,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.deletedAt,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'],
        address: json['address'],
        apartment: json['apartment'],
        entrance: json['entrance'],
        floor: json['floor'],
        comment: json['comment'],
        userId: json['userId'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
        deletedAt: json['deletedAt'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'address': address,
        'apartment': apartment,
        'entrance': entrance,
        'floor': floor,
        'comment': comment,
        'userId': userId,
        'latitude': latitude,
        'longitude': longitude,
        'createdAt': createdAt?.toIso8601String(),
        'deletedAt': deletedAt,
      };
}
