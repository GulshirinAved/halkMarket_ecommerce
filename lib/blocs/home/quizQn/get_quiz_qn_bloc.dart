import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/quiz_repository.dart';
import 'package:halkmarket_ecommerce/data/models/quiz_model.dart';

part 'get_quiz_qn_event.dart';
part 'get_quiz_qn_state.dart';

class GetQuizQnBloc extends Bloc<GetQuizQnEvent, GetQuizQnState> {
  final QuizRepository _quizRepository = QuizRepository();
  GetQuizQnBloc() : super(GetQuizQnInitial()) {
    on<GetQuestionEvent>((event, emit) async {
      try {
        final List<Row> quizList = await _quizRepository.getQuestions();
        emit(GetQuizQnLoaded(questionList: quizList));
      } catch (e) {
        emit(GetQuizQnError());
      }
    });
  }
}
