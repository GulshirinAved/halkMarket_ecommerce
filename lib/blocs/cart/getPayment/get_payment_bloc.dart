import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/getPayment_repository.dart';
import 'package:halkmarket_ecommerce/data/models/payment_model.dart';

part 'get_payment_event.dart';
part 'get_payment_state.dart';

class GetPaymentBloc extends Bloc<GetPaymentEvent, GetPaymentState> {
  final PaymentRepository _paymentRepository = PaymentRepository();
  GetPaymentBloc() : super(GetPaymentInitial()) {
    on<GetPaymentList>((event, emit) async {
      try {
        final List<Rows> paymentList = await _paymentRepository.getPayment();
        emit(GetPaymentLoaded(paymentList: paymentList));
      } catch (e) {
        emit(GetPaymentError(error: e.toString()));
      }
    });
  }
}
