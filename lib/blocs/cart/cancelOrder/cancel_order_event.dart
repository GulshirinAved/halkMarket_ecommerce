part of 'cancel_order_bloc.dart';

sealed class CancelOrderEvent extends Equatable {
  const CancelOrderEvent();

  @override
  List<Object> get props => [];
}

final class ButtonPressed extends CancelOrderEvent {
  final String id;

  const ButtonPressed({required this.id});
  @override
  List<Object> get props => [id];
}
