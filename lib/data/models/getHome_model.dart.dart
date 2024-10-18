import 'dart:convert';

import 'package:halkmarket_ecommerce/data/models/getAllProducts_model.dart';

class GetHomeModel {
  final int? statusCode;
  final bool? success;
  final List<Datum>? data;

  GetHomeModel({
    this.statusCode,
    this.success,
    this.data,
  });

  factory GetHomeModel.fromRawJson(String str) =>
      GetHomeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetHomeModel.fromJson(Map<String, dynamic> json) => GetHomeModel(
        statusCode: json['statusCode'],
        success: json['success'],
        data: json['data'] == null
            ? []
            : List<Datum>.from(json['data']!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'success': success,
        'data': data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final String? id;
  final String? type;
  final int? count;
  final String? categoryId;
  final DatumCategory? category;
  final List<Row>? rows;

  Datum({
    this.id,
    this.type,
    this.count,
    this.categoryId,
    this.category,
    this.rows,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'],
        type: json['type'],
        count: json['count'],
        categoryId: json['categoryId'],
        category: json['category'] == null
            ? null
            : DatumCategory.fromJson(json['category']),
        rows: json['rows'] == null
            ? []
            : List<Row>.from(json['rows']!.map((x) => Row.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'count': count,
        'categoryId': categoryId,
        'category': category?.toJson(),
        'rows': rows == null
            ? []
            : List<dynamic>.from(rows!.map((x) => x.toJson())),
      };
}

class DatumCategory {
  final String? id;
  final Image? image;
  final String? parentId;
  final DateTime? createdAt;
  final String? name;

  DatumCategory({
    this.id,
    this.image,
    this.parentId,
    this.createdAt,
    this.name,
  });

  factory DatumCategory.fromRawJson(String str) =>
      DatumCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DatumCategory.fromJson(Map<String, dynamic> json) => DatumCategory(
        id: json['id'],
        image: json['image'] == null ? null : Image.fromJson(json['image']),
        parentId: json['parentId'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image?.toJson(),
        'parentId': parentId,
        'createdAt': createdAt?.toIso8601String(),
        'name': name,
      };
}

class Image {
  final String? url;
  final String? hashblur;

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

class Row {
  final String? id;
  final DateTime? createdAt;
  final Image? image;
  final int? price;
  final int? usd;
  final int? coin;
  final List<Image>? images;
  final String? brandId;
  final String? shopId;
  final int? quantity;
  final String? visibility;
  final int? amount;
  final String? unitId;
  final Brand? brand;
  final List<CategoryElement>? categories;
  final String? name;
  final String? description;
  final bool? isLiked;
  final String? type;
  final String? title;
  final String? content;
  final SimpleDiscount? discount;
  final UnitModel? unit;

  Row({
    this.id,
    this.createdAt,
    this.image,
    this.price,
    this.usd,
    this.coin,
    this.images,
    this.brandId,
    this.shopId,
    this.quantity,
    this.visibility,
    this.amount,
    this.unitId,
    this.brand,
    this.categories,
    this.name,
    this.description,
    this.isLiked,
    this.type,
    this.title,
    this.content,
    this.discount,
    this.unit,
  });

  factory Row.fromRawJson(String str) => Row.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Row.fromJson(Map<String, dynamic> json) => Row(
        id: json['id'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
        image: json['image'] == null ? null : Image.fromJson(json['image']),
        price: json['price'],
        usd: json['usd'],
        coin: json['coin'],
        images: json['images'] == null
            ? []
            : List<Image>.from(json['images']!.map((x) => Image.fromJson(x))),
        brandId: json['brandId'],
        shopId: json['shopId'],
        quantity: json['quantity'],
        visibility: json['visibility'],
        amount: json['amount'],
        unitId: json['unitId'],
        brand: json['brand'] == null ? null : Brand.fromJson(json['brand']),
        categories: json['categories'] == null
            ? []
            : List<CategoryElement>.from(
                json['categories']!.map((x) => CategoryElement.fromJson(x)),
              ),
        name: json['name'],
        description: json['description'],
        isLiked: json['isLiked'],
        type: json['type'],
        title: json['title'],
        content: json['content'],
        discount: json['discount'] == null
            ? null
            : SimpleDiscount.fromJson(
                json['discount'],
              ),
        unit: json['unit'] == null ? null : UnitModel.fromJson(json['unit']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt?.toIso8601String(),
        'image': image?.toJson(),
        'price': price,
        'usd': usd,
        'coin': coin,
        'images': images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        'brandId': brandId,
        'shopId': shopId,
        'quantity': quantity,
        'visibility': visibility,
        'amount': amount,
        'unitId': unitId,
        'brand': brand?.toJson(),
        'categories': categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        'name': name,
        'description': description,
        'isLiked': isLiked,
        'type': type,
        'title': title,
        'content': content,
        'discount': discount?.toJson(),
        'unit': unit?.toJson(),
      };
}

class Brand {
  final String? id;
  final String? name;
  final Image? logo;
  final DateTime? createdAt;

  Brand({
    this.id,
    this.name,
    this.logo,
    this.createdAt,
  });

  factory Brand.fromRawJson(String str) => Brand.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json['id'],
        name: json['name'],
        logo: json['logo'] == null ? null : Image.fromJson(json['logo']),
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'logo': logo?.toJson(),
        'createdAt': createdAt?.toIso8601String(),
      };
}

class CategoryElement {
  final String? id;
  final String? name;

  CategoryElement({
    this.id,
    this.name,
  });

  factory CategoryElement.fromRawJson(String str) =>
      CategoryElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryElement.fromJson(Map<String, dynamic> json) =>
      CategoryElement(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
