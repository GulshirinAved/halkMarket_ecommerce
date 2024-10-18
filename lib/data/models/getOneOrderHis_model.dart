import 'dart:convert';

class OneOrderHistoryModel {
  final int? statusCode;
  final bool? success;
  final Datum? data;

  OneOrderHistoryModel({
    this.statusCode,
    this.success,
    this.data,
  });

  factory OneOrderHistoryModel.fromRawJson(String str) =>
      OneOrderHistoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OneOrderHistoryModel.fromJson(Map<String, dynamic> json) =>
      OneOrderHistoryModel(
        statusCode: json['statusCode'],
        success: json['success'],
        data: json['data'] == null ? null : Datum.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'success': success,
        'data': data?.toJson(),
      };
}

class Datum {
  final String? id;
  final String? address;
  final DateTime? until;
  final String? untilFrom;
  final String? untilTo;
  final int? price;
  final String? deliveryId;
  final String? paymentId;
  final String? userId;
  final String? status;
  final dynamic addressId;
  final DateTime? createdAt;
  final Delivery? payment;
  final Delivery? delivery;
  final List<OrderProduct>? orderProducts;

  Datum({
    this.id,
    this.address,
    this.until,
    this.untilFrom,
    this.untilTo,
    this.price,
    this.deliveryId,
    this.paymentId,
    this.userId,
    this.status,
    this.addressId,
    this.createdAt,
    this.payment,
    this.delivery,
    this.orderProducts,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'],
        address: json['address'],
        until: json['until'] == null ? null : DateTime.parse(json['until']),
        untilFrom: json['untilFrom'],
        untilTo: json['untilTo'],
        price: json['price'],
        deliveryId: json['deliveryId'],
        paymentId: json['paymentId'],
        userId: json['userId'],
        status: json['status'],
        addressId: json['addressId'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
        payment:
            json['payment'] == null ? null : Delivery.fromJson(json['payment']),
        delivery: json['delivery'] == null
            ? null
            : Delivery.fromJson(json['delivery']),
        orderProducts: json['orderProducts'] == null
            ? []
            : List<OrderProduct>.from(
                json['orderProducts']!.map((x) => OrderProduct.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'address': address,
        'until': until?.toIso8601String(),
        'untilFrom': untilFrom,
        'untilTo': untilTo,
        'price': price,
        'deliveryId': deliveryId,
        'paymentId': paymentId,
        'userId': userId,
        'status': status,
        'addressId': addressId,
        'createdAt': createdAt?.toIso8601String(),
        'payment': payment?.toJson(),
        'delivery': delivery?.toJson(),
        'orderProducts': orderProducts == null
            ? []
            : List<dynamic>.from(orderProducts!.map((x) => x.toJson())),
      };
}

class Delivery {
  final String? id;
  final int? price;
  final DateTime? createdAt;
  final String? name;
  final Logo? logo;

  Delivery({
    this.id,
    this.price,
    this.createdAt,
    this.name,
    this.logo,
  });

  factory Delivery.fromRawJson(String str) =>
      Delivery.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
        id: json['id'],
        price: json['price'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
        name: json['name'],
        logo: json['logo'] == null ? null : Logo.fromJson(json['logo']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'createdAt': createdAt?.toIso8601String(),
        'name': name,
        'logo': logo?.toJson(),
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

class OrderProduct {
  final String? id;
  final String? orderId;
  final String? productId;
  final int? quantity;
  final Product? product;

  OrderProduct({
    this.id,
    this.orderId,
    this.productId,
    this.quantity,
    this.product,
  });

  factory OrderProduct.fromRawJson(String str) =>
      OrderProduct.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
        id: json['id'],
        orderId: json['orderId'],
        productId: json['productId'],
        quantity: json['quantity'],
        product:
            json['product'] == null ? null : Product.fromJson(json['product']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'orderId': orderId,
        'productId': productId,
        'quantity': quantity,
        'product': product?.toJson(),
      };
}

class Product {
  final String? id;
  final int? price;
  final dynamic usd;
  final int? coin;
  final List<Logo>? images;
  final String? brandId;
  final int? quantity;
  final DateTime? createdAt;
  final String? visibility;
  final int? amount;
  final String? unitId;
  final dynamic sugar;
  final Delivery? brand;
  final Delivery? unit;
  final String? name;
  final String? description;
  final String? compound;
  final dynamic expiresIn;
  final bool? isLiked;
  final Discount? discount;

  Product({
    this.id,
    this.price,
    this.usd,
    this.coin,
    this.images,
    this.brandId,
    this.quantity,
    this.createdAt,
    this.visibility,
    this.amount,
    this.unitId,
    this.sugar,
    this.brand,
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
            : List<Logo>.from(json['images']!.map((x) => Logo.fromJson(x))),
        brandId: json['brandId'],
        quantity: json['quantity'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
        visibility: json['visibility'],
        amount: json['amount'],
        unitId: json['unitId'],
        sugar: json['sugar'],
        brand: json['brand'] == null ? null : Delivery.fromJson(json['brand']),
        unit: json['unit'] == null ? null : Delivery.fromJson(json['unit']),
        name: json['name'],
        description: json['description'],
        compound: json['compound'],
        expiresIn: json['expiresIn'],
        isLiked: json['isLiked'],
        discount: json['discount'] == null
            ? null
            : Discount.fromJson(json['discount']),
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
        'quantity': quantity,
        'createdAt': createdAt?.toIso8601String(),
        'visibility': visibility,
        'amount': amount,
        'unitId': unitId,
        'sugar': sugar,
        'brand': brand?.toJson(),
        'unit': unit?.toJson(),
        'name': name,
        'description': description,
        'compound': compound,
        'expiresIn': expiresIn,
        'isLiked': isLiked,
        'discount': discount?.toJson(),
      };
}

class Discount {
  final String? id;
  final int? discount;
  final String? description;
  final String? productId;

  Discount({
    this.id,
    this.discount,
    this.description,
    this.productId,
  });

  factory Discount.fromRawJson(String str) =>
      Discount.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
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
