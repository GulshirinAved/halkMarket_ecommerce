part of 'create_order_bloc.dart';

sealed class CreateOrderEvent extends Equatable {
  const CreateOrderEvent();

  @override
  List<Object> get props => [];
}

final class CreateOrderPressed extends CreateOrderEvent {
  final Map<String, dynamic> postData;

  const CreateOrderPressed({required this.postData});
  @override
  List<Object> get props => [postData];
}
