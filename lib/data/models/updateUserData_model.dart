import 'dart:convert';

class UpdateUserDataModel {
  final int? statusCode;
  final bool? success;
  final Data? data;

  UpdateUserDataModel({
    this.statusCode,
    this.success,
    this.data,
  });

  factory UpdateUserDataModel.fromRawJson(String str) =>
      UpdateUserDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateUserDataModel.fromJson(Map<String, dynamic> json) =>
      UpdateUserDataModel(
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
  final DateTime? birthday;
  final int? coins;
  final DateTime? createdAt;
  final dynamic email;
  final String? gender;
  final String? name;
  final String? phone;
  final String? fcmToken;
  final bool? emailNotifications;
  final bool? fcmNotifications;
  final bool? smsNotifications;
  final List<Address>? address;
  final List<dynamic>? viewedProduct;

  Data({
    this.id,
    this.birthday,
    this.coins,
    this.createdAt,
    this.email,
    this.gender,
    this.name,
    this.phone,
    this.fcmToken,
    this.emailNotifications,
    this.fcmNotifications,
    this.smsNotifications,
    this.address,
    this.viewedProduct,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'],
        birthday:
            json['birthday'] == null ? null : DateTime.parse(json['birthday']),
        coins: json['coins'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
        email: json['email'],
        gender: json['gender'],
        name: json['name'],
        phone: json['phone'],
        fcmToken: json['fcmToken'],
        emailNotifications: json['emailNotifications'],
        fcmNotifications: json['fcmNotifications'],
        smsNotifications: json['smsNotifications'],
        address: json['address'] == null
            ? []
            : List<Address>.from(
                json['address']!.map((x) => Address.fromJson(x)),
              ),
        viewedProduct: json['viewedProduct'] == null
            ? []
            : List<dynamic>.from(json['viewedProduct']!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'birthday': birthday?.toIso8601String(),
        'coins': coins,
        'createdAt': createdAt?.toIso8601String(),
        'email': email,
        'gender': gender,
        'name': name,
        'phone': phone,
        'fcmToken': fcmToken,
        'emailNotifications': emailNotifications,
        'fcmNotifications': fcmNotifications,
        'smsNotifications': smsNotifications,
        'address': address == null
            ? []
            : List<dynamic>.from(address!.map((x) => x.toJson())),
        'viewedProduct': viewedProduct == null
            ? []
            : List<dynamic>.from(viewedProduct!.map((x) => x)),
      };
}

class Address {
  final String? id;
  final String? address;
  final String? apartment;
  final String? comment;
  final String? entrance;
  final String? floor;
  final DateTime? createdAt;

  Address({
    this.id,
    this.address,
    this.apartment,
    this.comment,
    this.entrance,
    this.floor,
    this.createdAt,
  });

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json['id'],
        address: json['address'],
        apartment: json['apartment'],
        comment: json['comment'],
        entrance: json['entrance'],
        floor: json['floor'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'address': address,
        'apartment': apartment,
        'comment': comment,
        'entrance': entrance,
        'floor': floor,
        'createdAt': createdAt?.toIso8601String(),
      };
}
