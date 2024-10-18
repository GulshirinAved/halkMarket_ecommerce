import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/basket_repository.dart';

part 'cancel_order_event.dart';
part 'cancel_order_state.dart';

class CancelOrderBloc extends Bloc<CancelOrderEvent, CancelOrderState> {
  CancelOrderBloc() : super(CancelOrderInitial()) {
    final BasketRepository orderRepository = BasketRepository();
    on<ButtonPressed>((event, emit) async {
      final bool? canceled = await orderRepository.cancelOrder(id: event.id);
      if (canceled == true) {
        emit(CancelOrderLoaded());
      } else {
        emit(CancelOrderError());
      }
    });
  }
}
