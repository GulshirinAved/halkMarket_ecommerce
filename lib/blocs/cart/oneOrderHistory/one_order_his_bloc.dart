import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/basket_repository.dart';
import 'package:halkmarket_ecommerce/data/models/getOneOrderHis_model.dart';

part 'one_order_his_event.dart';
part 'one_order_his_state.dart';

class OneOrderHisBloc extends Bloc<OneOrderHisEvent, OneOrderHisState> {
  final BasketRepository historyRepository = BasketRepository();
  OneOrderHisBloc() : super(OneOrderHisInitial()) {
    on<GetOneHistory>((event, emit) async {
      try {
        final Datum? historyData =
            await historyRepository.getOneHistory(id: event.id);
        emit(OneOrderHisLoaded(orderData: historyData!));
      } catch (e) {
        emit(OneOrderHisError(error: e.toString()));
      }
    });
  }
}
