import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'to_order_event.dart';
part 'to_order_state.dart';

class ToOrderBloc extends Bloc<ToOrderEvent, ToOrderState> {
  ToOrderBloc()
      : super(
          const ToOrderState(
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
          ),
        ) {
    on<ToOrderEvent>((event, emit) {
      emit(
        state.copyWith(
          payment: event.selectedPayment ?? state.payment,
          deliveryName: event.selectedDeliveryName ?? state.deliveryName,
          deliveryPrice: event.selectedDeliveryPrice ?? state.deliveryPrice,
          deliveryId: event.selectedDeliveryId ?? state.deliveryId,
          paymentId: event.selectedPaymentId ?? state.paymentId,
          selectedAddress: event.selectedAddess ?? state.selectedAddress,
          until: event.until ?? state.until,
          untilTo: event.untilTo ?? state.untilTo,
          untilFrom: event.untilFrom ?? state.untilFrom,
        ),
      );
    });
  }
}
