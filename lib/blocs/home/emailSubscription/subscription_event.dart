part of 'subscription_bloc.dart';

sealed class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();

  @override
  List<Object> get props => [];
}

class Follow extends SubscriptionEvent {
  final String? email;

  const Follow({required this.email});
  @override
  List<Object> get props => [email ?? ''];
}
