import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/basket_repository.dart';
import 'package:halkmarket_ecommerce/data/models/orderHistory_model.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  final BasketRepository historyRepository = BasketRepository();
  OrderHistoryBloc() : super(OrderHistoryInitial()) {
    on<GetOrderHistory>((event, emit) async {
      try {
        final List<Row> historyList = await historyRepository.getHistory();
        emit(OrderHistoryLoaded(historyList: historyList));
      } catch (e) {
        emit(OrderHistoryError());
      }
    });
  }
}
