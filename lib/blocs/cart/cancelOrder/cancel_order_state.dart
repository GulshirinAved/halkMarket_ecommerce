part of 'cancel_order_bloc.dart';

sealed class CancelOrderState extends Equatable {
  const CancelOrderState();

  @override
  List<Object> get props => [];
}

final class CancelOrderInitial extends CancelOrderState {}

final class CancelOrderLoaded extends CancelOrderState {}

final class CancelOrderError extends CancelOrderState {}
