import 'dart:convert';

class OrderHistoryModel {
  final int? statusCode;
  final bool? success;
  final Data? data;

  OrderHistoryModel({
    this.statusCode,
    this.success,
    this.data,
  });

  factory OrderHistoryModel.fromRawJson(String str) =>
      OrderHistoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) =>
      OrderHistoryModel(
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
  final List<Row>? rows;

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
            : List<Row>.from(json['rows']!.map((x) => Row.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'pageCount': pageCount,
        'rows': rows == null
            ? []
            : List<dynamic>.from(rows!.map((x) => x.toJson())),
      };
}

class Row {
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

  Row({
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
  });

  factory Row.fromRawJson(String str) => Row.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Row.fromJson(Map<String, dynamic> json) => Row(
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
      };
}

class Delivery {
  final String? id;
  final int? price;
  final DateTime? createdAt;
  final String? name;

  Delivery({
    this.id,
    this.price,
    this.createdAt,
    this.name,
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
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'createdAt': createdAt?.toIso8601String(),
        'name': name,
      };
}
