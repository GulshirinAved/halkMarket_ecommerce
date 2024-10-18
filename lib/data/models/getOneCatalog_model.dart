import 'dart:convert';

class GetOneCatalogeModel {
  int? statusCode;
  bool? success;
  Data? data;

  GetOneCatalogeModel({
    this.statusCode,
    this.success,
    this.data,
  });

  factory GetOneCatalogeModel.fromRawJson(String str) =>
      GetOneCatalogeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetOneCatalogeModel.fromJson(Map<String, dynamic> json) =>
      GetOneCatalogeModel(
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
  String? id;
  Image? image;
  String? parentId;
  DateTime? createdAt;
  List<Data>? subcategories;
  String? name;

  Data({
    this.id,
    this.image,
    this.parentId,
    this.createdAt,
    this.subcategories,
    this.name,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'],
        image: json['image'] == null ? null : Image.fromJson(json['image']),
        parentId: json['parentId'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
        subcategories: json['subcategories'] == null
            ? []
            : List<Data>.from(
                json['subcategories']!.map((x) => Data.fromJson(x))),
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image?.toJson(),
        'parentId': parentId,
        'createdAt': createdAt?.toIso8601String(),
        'subcategories': subcategories == null
            ? []
            : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
        'name': name,
      };
}

class Image {
  String? url;
  String? hashblur;

  Image({
    this.url,
    this.hashblur,
  });

  factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json['url'],
        hashblur: json['hashblur'],
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'hashblur': hashblur,
      };
}
