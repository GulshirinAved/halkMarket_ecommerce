import 'dart:convert';

class FaqModel {
  final int? statusCode;
  final bool? success;
  final Data? data;

  FaqModel({
    this.statusCode,
    this.success,
    this.data,
  });

  factory FaqModel.fromRawJson(String str) =>
      FaqModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
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
  final DateTime? createdAt;
  final String? question;
  final String? answer;

  Row({
    this.id,
    this.createdAt,
    this.question,
    this.answer,
  });

  factory Row.fromRawJson(String str) => Row.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Row.fromJson(Map<String, dynamic> json) => Row(
        id: json['id'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
        question: json['question'],
        answer: json['answer'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt?.toIso8601String(),
        'question': question,
        'answer': answer,
      };
}
