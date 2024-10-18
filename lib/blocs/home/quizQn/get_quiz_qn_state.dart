part of 'get_quiz_qn_bloc.dart';

sealed class GetQuizQnState extends Equatable {
  const GetQuizQnState();

  @override
  List<Object> get props => [];
}

final class GetQuizQnInitial extends GetQuizQnState {}

final class GetQuizQnLoaded extends GetQuizQnState {
  final List<Row> questionList;

  const GetQuizQnLoaded({required this.questionList});
  @override
  List<Object> get props => [questionList];
}

final class GetQuizQnError extends GetQuizQnState {}
