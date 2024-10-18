import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:halkmarket_ecommerce/data/models/getAllProducts_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartItem {
  final String id;
  final String? name;
  final List<dynamic>? image;
  final int? price;
  final int? coin;
  final SimpleDiscount? discount;
  final String? desc;
  final bool? isSale;
  final bool? isNew;
  final double? weight;
  final bool? sugar;
  final String? shopId;
  final int? amount;
  final UnitModel? unit;
  int quantity;
  CartItem({
    required this.id,
    required this.shopId,
    this.name,
    this.image,
    this.price,
    this.coin,
    this.discount,
    this.desc,
    this.isSale,
    this.isNew,
    this.weight,
    this.sugar,
    this.amount,
    this.unit,
    this.quantity = 1,
  });

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
      'weight': weight,
      'sugar': sugar,
      'shopId': shopId,
      'quantity': quantity,
      'amount': amount,
      'unit': unit,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
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
      weight: map['weight'] != null ? map['weight'] as double : null,
      sugar: map['sugar'] != null ? map['sugar'] as bool : null,
      shopId: map['shopId'] != null ? map['shopId'] as String : null,
      amount: map['amount'] != null ? map['amount'] as int : null,
      unit: map['unit'] == null ? null : UnitModel.fromJson(map['unit']),
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

  CartItem copyWith({
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
    double? weight,
    bool? sugar,
    String? shopId,
    int? amount,
    UnitModel? unit,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      coin: coin ?? this.coin,
      discount: discount ?? this.discount,
      desc: desc ?? this.desc,
      isSale: isSale ?? this.isSale,
      isNew: isNew ?? this.isNew,
      weight: weight ?? this.weight,
      sugar: sugar ?? this.sugar,
      shopId: shopId ?? this.shopId,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  bool operator ==(covariant CartItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.image, image) &&
        other.price == price &&
        other.coin == coin &&
        other.discount == discount &&
        other.desc == desc &&
        other.isSale == isSale &&
        other.isNew == isNew &&
        other.weight == weight &&
        other.sugar == sugar &&
        other.shopId == shopId &&
        other.amount == amount &&
        other.unit == unit &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        image.hashCode ^
        price.hashCode ^
        coin.hashCode ^
        discount.hashCode ^
        desc.hashCode ^
        isSale.hashCode ^
        isNew.hashCode ^
        weight.hashCode ^
        sugar.hashCode ^
        shopId.hashCode ^
        unit.hashCode ^
        amount.hashCode ^
        quantity.hashCode;
  }
}
