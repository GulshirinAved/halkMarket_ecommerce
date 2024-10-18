part of 'one_order_his_bloc.dart';

sealed class OneOrderHisEvent extends Equatable {
  const OneOrderHisEvent();

  @override
  List<Object> get props => [];
}

final class GetOneHistory extends OneOrderHisEvent {
  final String id;

  const GetOneHistory({required this.id});
  @override
  List<Object> get props => [id];
}
