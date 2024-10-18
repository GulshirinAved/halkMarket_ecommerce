import 'dart:convert';

import 'package:halkmarket_ecommerce/data/models/getAllProducts_model.dart';

class AllOrdersModel {
  final int? statusCode;
  final bool? success;
  final Data? data;

  AllOrdersModel({
    this.statusCode,
    this.success,
    this.data,
  });

  factory AllOrdersModel.fromRawJson(String str) =>
      AllOrdersModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllOrdersModel.fromJson(Map<String, dynamic> json) => AllOrdersModel(
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
  final Product? product;
  final List<Product>? similaryProducts;

  Data({
    this.product,
    this.similaryProducts,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        product:
            json['product'] == null ? null : Product.fromJson(json['product']),
        similaryProducts: json['similaryProducts'] == null
            ? []
            : List<Product>.from(
                json['similaryProducts']!.map((x) => Product.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        'product': product?.toJson(),
        'similaryProducts': similaryProducts == null
            ? []
            : List<dynamic>.from(similaryProducts!.map((x) => x.toJson())),
      };
}

class Product {
  final String? id;
  final int? price;
  final dynamic usd;
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
  final List<Category>? categories;
  final UnitModel? unit;
  final String? name;
  final String? description;
  final String? compound;
  final dynamic expiresIn;
  final bool? isLiked;
  final SimpleDiscount? discount;

  Product({
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
    this.compound,
    this.expiresIn,
    this.isLiked,
    this.discount,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        price: json['price'],
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
        amount: json['amount'],
        unitId: json['unitId'],
        brand: json['brand'] == null ? null : Brand.fromJson(json['brand']),
        shop: json['shop'] == null ? null : Brand.fromJson(json['shop']),
        categories: json['categories'] == null
            ? []
            : List<Category>.from(
                json['categories']!.map((x) => Category.fromJson(x)),
              ),
        unit: json['unit'] == null ? null : UnitModel.fromJson(json['unit']),
        name: json['name'],
        description: json['description'],
        compound: json['compound'],
        expiresIn: json['expiresIn'],
        isLiked: json['isLiked'],
        discount: json['discount'] == null
            ? null
            : SimpleDiscount.fromJson(json['discount']),
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
        'compound': compound,
        'expiresIn': expiresIn,
        'isLiked': isLiked,
        'discount': discount?.toJson(),
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

class Category {
  final String? id;
  final String? name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
