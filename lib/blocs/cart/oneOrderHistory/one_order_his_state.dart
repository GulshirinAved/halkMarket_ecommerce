part of 'one_order_his_bloc.dart';

sealed class OneOrderHisState extends Equatable {
  const OneOrderHisState();

  @override
  List<Object> get props => [];
}

final class OneOrderHisInitial extends OneOrderHisState {}

final class OneOrderHisLoaded extends OneOrderHisState {
  final Datum orderData;

  const OneOrderHisLoaded({required this.orderData});
  @override
  List<Object> get props => [orderData];
}

final class OneOrderHisError extends OneOrderHisState {
  final String error;

  const OneOrderHisError({required this.error});
  @override
  List<Object> get props => [error];
}
