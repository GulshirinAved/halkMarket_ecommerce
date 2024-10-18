import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/delivery_repository.dart';

part 'get_delivery_event.dart';
part 'get_delivery_state.dart';

class GetDeliveryBloc extends Bloc<GetDeliveryEvent, GetDeliveryState> {
  final DeliveryRepository deliveryRepository = DeliveryRepository();
  GetDeliveryBloc() : super(GetDeliveryInitial()) {
    on<GetDeliveryList>((event, emit) async {
      try {
        final List deliveryList = await deliveryRepository.getDeliveryType();
        emit(GetDeliveryLoaded(deliveryList: deliveryList));
      } catch (e) {
        emit(GetDeliveryError(error: e.toString()));
      }
    });
  }
}
