part of 'order_history_bloc.dart';

sealed class OrderHistoryState extends Equatable {
  const OrderHistoryState();

  @override
  List<Object> get props => [];
}

final class OrderHistoryInitial extends OrderHistoryState {}

final class OrderHistoryLoaded extends OrderHistoryState {
  final List<Row> historyList;

  const OrderHistoryLoaded({required this.historyList});
  @override
  List<Object> get props => [historyList];
}

final class OrderHistoryError extends OrderHistoryState {}
