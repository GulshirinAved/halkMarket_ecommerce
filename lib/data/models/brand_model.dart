import 'dart:convert';

class BrandModel {
  final int? statusCode;
  final bool? success;
  final Data? data;

  BrandModel({
    this.statusCode,
    this.success,
    this.data,
  });

  factory BrandModel.fromRawJson(String str) =>
      BrandModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
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
  final int? pageCount;
  final int? count;
  final List<Row>? rows;

  Data({
    this.pageCount,
    this.count,
    this.rows,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pageCount: json['pageCount'],
        count: json['count'],
        rows: json['rows'] == null
            ? []
            : List<Row>.from(json['rows']!.map((x) => Row.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'pageCount': pageCount,
        'count': count,
        'rows': rows == null
            ? []
            : List<dynamic>.from(rows!.map((x) => x.toJson())),
      };
}

class Row {
  final String? id;
  final String? name;
  final Logo? logo;
  final List<Category>? categories;

  Row({
    this.id,
    this.name,
    this.logo,
    this.categories,
  });

  factory Row.fromRawJson(String str) => Row.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Row.fromJson(Map<String, dynamic> json) => Row(
        id: json['id'],
        name: json['name'],
        logo: json['logo'] == null ? null : Logo.fromJson(json['logo']),
        categories: json['categories'] == null
            ? []
            : List<Category>.from(
                json['categories']!.map((x) => Category.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'logo': logo?.toJson(),
        'categories': categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class Category {
  final String? id;
  final Logo? image;
  final String? name;

  Category({
    this.id,
    this.image,
    this.name,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        image: json['image'] == null ? null : Logo.fromJson(json['image']),
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image?.toJson(),
        'name': name,
      };
}

class Logo {
  final String? url;
  final String? hashblur;

  Logo({
    this.url,
    this.hashblur,
  });

  factory Logo.fromRawJson(String str) => Logo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Logo.fromJson(Map<String, dynamic> json) => Logo(
        url: json['url'],
        hashblur: json['hashblur'],
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'hashblur': hashblur,
      };
}
