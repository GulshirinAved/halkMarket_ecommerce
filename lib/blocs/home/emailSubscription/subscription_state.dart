part of 'subscription_bloc.dart';

sealed class SubscriptionState extends Equatable {
  const SubscriptionState();

  @override
  List<Object> get props => [];
}

final class SubscriptionInitial extends SubscriptionState {}

final class SubscriptionLoading extends SubscriptionState {}

final class SubscriptionLoaded extends SubscriptionState {
  final List subscriptionList;

  const SubscriptionLoaded({required this.subscriptionList});
  @override
  List<Object> get props => [subscriptionList];
}

final class SubscriptionError extends SubscriptionState {
  final String? error;

  const SubscriptionError({required this.error});
  @override
  List<Object> get props => [error ?? ''];
}
