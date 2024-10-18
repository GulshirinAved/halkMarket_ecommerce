import 'dart:convert';

class DeliveryModel {
  final int? statusCode;
  final bool? success;
  final Data? data;

  DeliveryModel({
    this.statusCode,
    this.success,
    this.data,
  });

  factory DeliveryModel.fromRawJson(String str) =>
      DeliveryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeliveryModel.fromJson(Map<String, dynamic> json) => DeliveryModel(
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
  final int? count;
  final int? pageCount;
  final List<Row>? rows;

  Data({
    this.count,
    this.pageCount,
    this.rows,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json['count'],
        pageCount: json['pageCount'],
        rows: json['rows'] == null
            ? []
            : List<Row>.from(json['rows']!.map((x) => Row.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'pageCount': pageCount,
        'rows': rows == null
            ? []
            : List<dynamic>.from(rows!.map((x) => x.toJson())),
      };
}

class Row {
  final String? id;
  final int? price;
  final DateTime? createdAt;
  final List<Translation>? translations;
  final String? name;
  final String? description;

  Row({
    this.id,
    this.price,
    this.createdAt,
    this.translations,
    this.name,
    this.description,
  });

  factory Row.fromRawJson(String str) => Row.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Row.fromJson(Map<String, dynamic> json) => Row(
        id: json['id'],
        price: json['price'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
        translations: json['translations'] == null
            ? []
            : List<Translation>.from(
                json['translations']!.map((x) => Translation.fromJson(x)),
              ),
        name: json['name'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'createdAt': createdAt?.toIso8601String(),
        'translations': translations == null
            ? []
            : List<dynamic>.from(translations!.map((x) => x.toJson())),
        'name': name,
        'description': description,
      };
}

class Translation {
  final String? lang;
  final String? name;
  final String? description;

  Translation({
    this.lang,
    this.name,
    this.description,
  });

  factory Translation.fromRawJson(String str) =>
      Translation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        lang: json['lang'],
        name: json['name'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'lang': lang,
        'name': name,
        'description': description,
      };
}
