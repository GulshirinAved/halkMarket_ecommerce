import 'dart:convert';

class GetAllProductsModel {
  final int? statusCode;
  final bool? success;
  final Data? data;

  GetAllProductsModel({
    this.statusCode,
    this.success,
    this.data,
  });

  factory GetAllProductsModel.fromRawJson(String str) =>
      GetAllProductsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAllProductsModel.fromJson(Map<String, dynamic> json) =>
      GetAllProductsModel(
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
  final DataCategory? category;
  final List<Row>? rows;

  Data({
    this.count,
    this.pageCount,
    this.category,
    this.rows,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json['count'],
        pageCount: json['pageCount'],
        category: json['category'] == null
            ? null
            : DataCategory.fromJson(json['category']),
        rows: json['rows'] == null
            ? []
            : List<Row>.from(json['rows']!.map((x) => Row.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'pageCount': pageCount,
        'category': category?.toJson(),
        'rows': rows == null
            ? []
            : List<dynamic>.from(rows!.map((x) => x.toJson())),
      };
}

class DataCategory {
  final String? id;
  final Image? image;
  final String? parentId;
  final DateTime? createdAt;
  final String? name;

  DataCategory({
    this.id,
    this.image,
    this.parentId,
    this.createdAt,
    this.name,
  });

  factory DataCategory.fromRawJson(String str) =>
      DataCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataCategory.fromJson(Map<String, dynamic> json) => DataCategory(
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
  final int? price;
  final int? usd;
  final int? coin;
  final List<Image>? images;
  final String? brandId;
  final String? shopId;
  final int? quantity;
  final DateTime? createdAt;
  final String? visibility;
  final int? amount;
  final String? unitId;
  final Brand? brand;
  final Brand? shop;
  final List<CategoryElement>? categories;
  final String? name;
  final String? description;
  final bool? isLiked;
  final SimpleDiscount? discount;
  final bool? sugar;
  final UnitModel? unit;

  Row({
    this.id,
    this.price,
    this.usd,
    this.coin,
    this.images,
    this.brandId,
    this.shopId,
    this.quantity,
    this.createdAt,
    this.visibility,
    this.amount,
    this.unitId,
    this.brand,
    this.shop,
    this.categories,
    this.unit,
    this.name,
    this.description,
    this.isLiked,
    this.discount,
    this.sugar,
  });

  factory Row.fromRawJson(String str) => Row.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Row.fromJson(Map<String, dynamic> json) => Row(
        id: json['id'],
        price: json['price'] is int
            ? json['price']
            : (json['price'] as double?)?.toInt(),
        usd: json['usd'],
        coin: json['coin'],
        images: json['images'] == null
            ? []
            : List<Image>.from(json['images']!.map((x) => Image.fromJson(x))),
        brandId: json['brandId'],
        shopId: json['shopId'],
        quantity: json['quantity'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
        visibility: json['visibility'],
        amount: json['amount'] is int
            ? json['amount']
            : (json['amount'] as double?)?.toInt(),
        unitId: json['unitId'],
        brand: json['brand'] == null ? null : Brand.fromJson(json['brand']),
        shop: json['shop'] == null ? null : Brand.fromJson(json['shop']),
        categories: json['categories'] == null
            ? []
            : List<CategoryElement>.from(
                json['categories']!.map((x) => CategoryElement.fromJson(x)),
              ),
        unit: json['unit'] == null ? null : UnitModel.fromJson(json['unit']),
        name: json['name'],
        description: json['description'],
        isLiked: json['isLiked'],
        discount: json['discount'] == null
            ? null
            : SimpleDiscount.fromJson(json['discount']),
        sugar: json['sugar'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'usd': usd,
        'coin': coin,
        'images': images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        'brandId': brandId,
        'shopId': shopId,
        'quantity': quantity,
        'createdAt': createdAt?.toIso8601String(),
        'visibility': visibility,
        'amount': amount,
        'unitId': unitId,
        'brand': brand?.toJson(),
        'shop': shop?.toJson(),
        'categories': categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        'unit': unit?.toJson(),
        'name': name,
        'description': description,
        'isLiked': isLiked,
        'discount': discount?.toJson(),
        'sugar': sugar,
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

class SimpleDiscount {
  final String? id;
  final int? discount;
  final String? description;
  final String? productId;

  SimpleDiscount({
    required this.id,
    required this.discount,
    required this.description,
    required this.productId,
  });

  factory SimpleDiscount.fromRawJson(String str) =>
      SimpleDiscount.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SimpleDiscount.fromJson(Map<String, dynamic> json) => SimpleDiscount(
        id: json['id'],
        discount: json['discount'],
        description: json['description'],
        productId: json['productId'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'discount': discount,
        'description': description,
        'productId': productId,
      };
}

class UnitModel {
  final String? id;
  final String? createdAt;
  final String? name;

  UnitModel({
    required this.id,
    required this.createdAt,
    required this.name,
  });

  factory UnitModel.fromRawJson(String str) =>
      UnitModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
        id: json['id'],
        createdAt: json['createdAt'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt,
        'name': name,
      };
}
