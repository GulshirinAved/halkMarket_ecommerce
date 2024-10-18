part of 'get_payment_bloc.dart';

sealed class GetPaymentEvent extends Equatable {
  const GetPaymentEvent();

  @override
  List<Object> get props => [];
}

final class GetPaymentList extends GetPaymentEvent {}
