part of 'get_delivery_bloc.dart';

sealed class GetDeliveryEvent extends Equatable {
  const GetDeliveryEvent();

  @override
  List<Object> get props => [];
}

final class GetDeliveryList extends GetDeliveryEvent {
  const GetDeliveryList();
}
