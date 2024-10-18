import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:halkmarket_ecommerce/data/models/getAllProducts_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FavItem {
  final String id;
  final String? name;
  final List<dynamic>? image;
  final int? price;
  final int? coin;
  final SimpleDiscount? discount;
  final String? desc;
  final bool? isSale;
  final bool? isNew;
  final bool? sugar;
  final String? shopId;
  final int? amount;
  final UnitModel? unit;

  bool? isFavorite;
  FavItem({
    required this.id,
    this.name,
    this.image,
    this.price,
    this.coin,
    this.discount,
    this.desc,
    this.isSale,
    this.isNew,
    this.sugar,
    this.shopId,
    this.amount,
    this.unit,
    this.isFavorite,
  });

  FavItem copyWith({
    String? id,
    String? name,
    List<dynamic>? image,
    int? price,
    int? coin,
    String? prevPrice,
    SimpleDiscount? discount,
    String? desc,
    bool? isSale,
    bool? isNew,
    bool? sugar,
    String? shopId,
    int? amount,
    UnitModel? unit,
    bool? isFavorite,
  }) {
    return FavItem(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      coin: coin ?? this.coin,
      discount: discount ?? this.discount,
      desc: desc ?? this.desc,
      isSale: isSale ?? this.isSale,
      isNew: isNew ?? this.isNew,
      sugar: sugar ?? sugar,
      shopId: shopId ?? this.shopId,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'coin': coin,
      'discount': discount,
      'desc': desc,
      'isSale': isSale,
      'isNew': isNew,
      'sugar': sugar,
      'shopId': shopId,
      'amount': amount,
      'unit': unit,
      'isFavorite': isFavorite,
    };
  }

  factory FavItem.fromMap(Map<String, dynamic> map) {
    return FavItem(
      id: map['id'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null
          ? List<dynamic>.from(map['image'] as List<dynamic>)
          : null,
      price: map['price'] != null ? map['price'] as int : null,
      coin: map['coin'] != null ? map['coin'] as int : null,
      discount: map['discount'] == null
          ? null
          : SimpleDiscount.fromJson(map['discount']),
      desc: map['desc'] != null ? map['desc'] as String : null,
      isSale: map['isSale'] != null ? map['isSale'] as bool : null,
      isNew: map['isNew'] != null ? map['isNew'] as bool : null,
      sugar: map['sugar'] != null ? map['sugar'] as bool : null,
      shopId: map['shopId'] != null ? map['shopId'] as String : null,
      amount: map['amount'] != null ? map['amount'] as int : null,
      unit: map['unit'] == null ? null : UnitModel.fromJson(map['unit']),
      isFavorite: map['isFavorite'] != null ? map['isFavorite'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavItem.fromJson(String source) =>
      FavItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant FavItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.image, image) &&
        other.price == price &&
        other.coin == coin &&
        other.amount == amount &&
        other.discount == discount &&
        other.desc == desc &&
        other.isSale == isSale &&
        other.isNew == isNew &&
        other.sugar == sugar &&
        other.shopId == shopId &&
        other.unit == unit &&
        other.isFavorite == isFavorite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        image.hashCode ^
        price.hashCode ^
        amount.hashCode ^
        coin.hashCode ^
        discount.hashCode ^
        desc.hashCode ^
        isSale.hashCode ^
        isNew.hashCode ^
        sugar.hashCode ^
        shopId.hashCode ^
        unit.hashCode ^
        isFavorite.hashCode;
  }
}
