part of 'get_quiz_qn_bloc.dart';

sealed class GetQuizQnEvent extends Equatable {
  const GetQuizQnEvent();

  @override
  List<Object> get props => [];
}

final class GetQuestionEvent extends GetQuizQnEvent {}
