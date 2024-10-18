part of 'create_feedback_bloc.dart';

sealed class CreateFeedbackEvent extends Equatable {
  const CreateFeedbackEvent();

  @override
  List<Object> get props => [];
}

final class SendMessage extends CreateFeedbackEvent {
  final String name;
  final String phone;
  final String message;

  const SendMessage({
    required this.name,
    required this.phone,
    required this.message,
  });
  @override
  List<Object> get props => [
        name,
        phone,
        message,
      ];
}
