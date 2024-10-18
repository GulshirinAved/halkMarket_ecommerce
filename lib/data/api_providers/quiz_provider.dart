import 'package:dio/dio.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';
import 'package:halkmarket_ecommerce/data/models/quiz_model.dart';
import 'package:hive/hive.dart';

class QuizProvider {
  Dio dio = Dio();
  final Box langBox = Hive.box('lang');
  Future<List<Row>> getQuestions() async {
    try {
      final Response response = await dio.get(
        Endpoints().getQuestions,
      );
      dio.options.headers = {
        'Accept-Language': langBox.get('lang') ?? 'tr',
        'Content-Type': 'application/json; charset=UTF-8',
      };
      if (response.statusCode == 200) {
        final List<dynamic> questionData = response.data['data']['rows'];
        final List<Row> questionList = questionData
            .where(
              (element) => element['answers'].isNotEmpty,
            )
            .map(
              (e) => Row.fromJson(e),
            )
            .toList();
        return questionList;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> vote(final String? id) async {
    final Response response = await dio.post(Endpoints().voteAnswer(id: id));
    try {
      if (response.statusCode == 201) {
        return response.data['data'];
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
