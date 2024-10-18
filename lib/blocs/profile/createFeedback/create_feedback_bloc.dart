import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/createFeedback_repository.dart';

part 'create_feedback_event.dart';
part 'create_feedback_state.dart';

class CreateFeedbackBloc
    extends Bloc<CreateFeedbackEvent, CreateFeedbackState> {
  final CreatefeedbackRepository feedbackRepository =
      CreatefeedbackRepository();
  CreateFeedbackBloc() : super(CreateFeedbackInitial()) {
    on<SendMessage>((event, emit) async {
      try {
        final bool? isCreated = await feedbackRepository.createFeedback(
          name: event.name,
          phone: event.phone,
          message: event.message,
        );
        emit(CreateFeedbackSuccess(isCreated: isCreated));
      } catch (e) {
        emit(CreateFeedbackError());
      }
    });
  }
}
