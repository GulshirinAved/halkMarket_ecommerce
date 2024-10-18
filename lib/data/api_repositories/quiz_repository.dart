import 'package:halkmarket_ecommerce/data/api_providers/quiz_provider.dart';
import 'package:halkmarket_ecommerce/data/models/quiz_model.dart';

class QuizRepository {
  final QuizProvider _quizProvider = QuizProvider();
  Future<List<Row>> getQuestions() async {
    return _quizProvider.getQuestions();
  }

  Future<bool> vote({required String? id}) async {
    return _quizProvider.vote(id);
  }
}
