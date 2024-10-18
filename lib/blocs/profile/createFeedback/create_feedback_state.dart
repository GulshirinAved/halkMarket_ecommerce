part of 'create_feedback_bloc.dart';

sealed class CreateFeedbackState extends Equatable {
  const CreateFeedbackState();

  @override
  List<Object> get props => [];
}

final class CreateFeedbackInitial extends CreateFeedbackState {}

final class CreateFeedbackSuccess extends CreateFeedbackState {
  final bool? isCreated;

  const CreateFeedbackSuccess({required this.isCreated});
  @override
  List<Object> get props => [isCreated ?? false];
}

final class CreateFeedbackError extends CreateFeedbackState {}
