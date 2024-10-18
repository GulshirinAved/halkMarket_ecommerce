import 'dart:convert';

class PaymentModel {
  final int? statusCode;
  final bool? success;
  final Data? data;

  PaymentModel({
    this.statusCode,
    this.success,
    this.data,
  });

  factory PaymentModel.fromRawJson(String str) =>
      PaymentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
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
  final List<Rows>? rows;

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
            : List<Rows>.from(json['rows']!.map((x) => Rows.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'pageCount': pageCount,
        'rows': rows == null
            ? []
            : List<dynamic>.from(rows!.map((x) => x.toJson())),
      };
}

class Rows {
  final String? id;
  final DateTime? createdAt;
  final List<Translation>? translations;
  final String? name;
  final String? description;

  Rows({
    this.id,
    this.createdAt,
    this.translations,
    this.name,
    this.description,
  });

  factory Rows.fromRawJson(String str) => Rows.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Rows.fromJson(Map<String, dynamic> json) => Rows(
        id: json['id'],
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
