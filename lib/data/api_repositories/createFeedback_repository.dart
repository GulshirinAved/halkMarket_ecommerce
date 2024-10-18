import 'package:halkmarket_ecommerce/data/api_providers/createFeedback_provider.dart';

class CreatefeedbackRepository {
  final CreateFeedbackProvider feedbackProvider = CreateFeedbackProvider();
  Future<bool?> createFeedback({
    String? name,
    String? message,
    String? phone,
    String? email,
  }) async {
    return feedbackProvider.createFeedback(
      name: name,
      message: message,
      phone: phone,
      email: email,
    );
  }
}
