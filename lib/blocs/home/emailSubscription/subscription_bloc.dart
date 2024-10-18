import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/emailSubscription_repository.dart';
import 'package:halkmarket_ecommerce/data/models/brand_model.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  SubscriptionBloc() : super(SubscriptionInitial()) {
    final EmailSubscriptionRepository emailSubscriptionRepository =
        EmailSubscriptionRepository();
    on<Follow>((event, emit) async {
      try {
        final List<Data> subscribeList =
            await emailSubscriptionRepository.subscribe(email: event.email);
        emit(SubscriptionLoaded(subscriptionList: subscribeList));
      } catch (e) {
        emit(SubscriptionError(error: e.toString()));
      }
    });
  }
}
