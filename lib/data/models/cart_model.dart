import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartItem {
  final String id;
  final String? name;
  final List<dynamic>? image;
  final int? price;
  final int? coin;
  final String? prevPrice;
  final String? discount;
  final String? desc;
  final bool? isSale;
  final bool? isNew;
  final double? weight;
  final bool? withSugar;
  int quantity;
  CartItem({
    required this.id,
    this.name,
    this.image,
    this.price,
    this.coin,
    this.prevPrice,
    this.discount,
    this.desc,
    this.isSale,
    this.isNew,
    this.weight,
    this.withSugar,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'coin': coin,
      'prevPrice': prevPrice,
      'discount': discount,
      'desc': desc,
      'isSale': isSale,
      'isNew': isNew,
      'weight': weight,
      'withSugar': withSugar,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null
          ? List<dynamic>.from((map['image'] as List<dynamic>))
          : null,
      price: map['price'] != null ? map['price'] as int : null,
      coin: map['coin'] != null ? map['coin'] as int : null,
      prevPrice: map['prevPrice'] != null ? map['prevPrice'] as String : null,
      discount: map['discount'] != null ? map['discount'] as String : null,
      desc: map['desc'] != null ? map['desc'] as String : null,
      isSale: map['isSale'] != null ? map['isSale'] as bool : null,
      isNew: map['isNew'] != null ? map['isNew'] as bool : null,
      weight: map['weight'] != null ? map['weight'] as double : null,
      withSugar: map['withSugar'] != null ? map['withSugar'] as bool : null,
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
    String? discount,
    String? desc,
    bool? isSale,
    bool? isNew,
    double? weight,
    bool? withSugar,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      coin: coin ?? this.coin,
      prevPrice: prevPrice ?? this.prevPrice,
      discount: discount ?? this.discount,
      desc: desc ?? this.desc,
      isSale: isSale ?? this.isSale,
      isNew: isNew ?? this.isNew,
      weight: weight ?? this.weight,
      withSugar: withSugar ?? this.withSugar,
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
        other.prevPrice == prevPrice &&
        other.discount == discount &&
        other.desc == desc &&
        other.isSale == isSale &&
        other.isNew == isNew &&
        other.weight == weight &&
        other.withSugar == withSugar &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        image.hashCode ^
        price.hashCode ^
        coin.hashCode ^
        prevPrice.hashCode ^
        discount.hashCode ^
        desc.hashCode ^
        isSale.hashCode ^
        isNew.hashCode ^
        weight.hashCode ^
        withSugar.hashCode ^
        quantity.hashCode;
  }
}
