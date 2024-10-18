import 'dart:convert';

class QuizModel {
  final int? statusCode;
  final bool? success;
  final Data? data;

  QuizModel({
    this.statusCode,
    this.success,
    this.data,
  });

  factory QuizModel.fromRawJson(String str) =>
      QuizModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
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
  final DateTime? createdAt;
  final List<Translate>? translates;
  final List<Answer>? answers;
  final String? title;

  Row({
    this.id,
    this.createdAt,
    this.translates,
    this.answers,
    this.title,
  });

  factory Row.fromRawJson(String str) => Row.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Row.fromJson(Map<String, dynamic> json) => Row(
        id: json['id'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
        translates: json['translates'] == null
            ? []
            : List<Translate>.from(
                json['translates']!.map((x) => Translate.fromJson(x)),
              ),
        answers: json['answers'] == null
            ? []
            : List<Answer>.from(
                json['answers']!.map((x) => Answer.fromJson(x)),
              ),
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt?.toIso8601String(),
        'translates': translates == null
            ? []
            : List<dynamic>.from(translates!.map((x) => x.toJson())),
        'answers': answers == null
            ? []
            : List<dynamic>.from(answers!.map((x) => x.toJson())),
        'title': title,
      };
}

class Answer {
  final String? id;
  final String? questionId;
  final int? votes;
  final DateTime? createdAt;
  final List<Translate>? translates;
  final String? title;

  Answer({
    this.id,
    this.questionId,
    this.votes,
    this.createdAt,
    this.translates,
    this.title,
  });

  factory Answer.fromRawJson(String str) => Answer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json['id'],
        questionId: json['questionId'],
        votes: json['votes'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
        translates: json['translates'] == null
            ? []
            : List<Translate>.from(
                json['translates']!.map((x) => Translate.fromJson(x)),
              ),
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'questionId': questionId,
        'votes': votes,
        'createdAt': createdAt?.toIso8601String(),
        'translates': translates == null
            ? []
            : List<dynamic>.from(translates!.map((x) => x.toJson())),
        'title': title,
      };
}

class Translate {
  final String? lang;
  final String? title;

  Translate({
    this.lang,
    this.title,
  });

  factory Translate.fromRawJson(String str) =>
      Translate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Translate.fromJson(Map<String, dynamic> json) => Translate(
        lang: json['lang'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'lang': lang,
        'title': title,
      };
}
