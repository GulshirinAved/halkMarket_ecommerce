import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/createOrder_repository.dart';
import 'package:hive/hive.dart';

part 'create_order_event.dart';
part 'create_order_state.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  CreateOrderBloc() : super(CreateOrderInitial()) {
    final CreateOrderRepository createOrderRepository = CreateOrderRepository();
    final Box box = Hive.box('cartBox');

    on<CreateOrderPressed>((event, emit) async {
      final bool result =
          await createOrderRepository.createOrder(postData: event.postData);
      if (result == true) {
        await box.clear();
        emit(const CreateOrderSuccess());
      } else {
        emit(const CreateOrderFailure('Something went wrong!'));
      }
    });
  }
}
