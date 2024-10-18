part of 'get_delivery_bloc.dart';

sealed class GetDeliveryState extends Equatable {
  const GetDeliveryState();

  @override
  List<Object> get props => [];
}

final class GetDeliveryInitial extends GetDeliveryState {}

final class GetDeliveryLoaded extends GetDeliveryState {
  final List deliveryList;

  const GetDeliveryLoaded({required this.deliveryList});

  @override
  List<Object> get props => [deliveryList];
}

final class GetDeliveryError extends GetDeliveryState {
  final String error;

  const GetDeliveryError({required this.error});
  @override
  List<Object> get props => [error];
}
