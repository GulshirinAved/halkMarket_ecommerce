part of 'create_order_bloc.dart';

sealed class CreateOrderState extends Equatable {
  const CreateOrderState();

  @override
  List<Object> get props => [];
}

final class CreateOrderInitial extends CreateOrderState {}

final class CreateOrderSuccess extends CreateOrderState {
  const CreateOrderSuccess();
}

final class CreateOrderFailure extends CreateOrderState {
  final String? error;
  const CreateOrderFailure(this.error);

  @override
  List<Object> get props => [error ?? ''];
}
