part of 'get_payment_bloc.dart';

sealed class GetPaymentState extends Equatable {
  const GetPaymentState();

  @override
  List<Object> get props => [];
}

final class GetPaymentInitial extends GetPaymentState {}

final class GetPaymentLoaded extends GetPaymentState {
  final List<Rows> paymentList;

  const GetPaymentLoaded({required this.paymentList});
  @override
  List<Object> get props => [paymentList];
}

final class GetPaymentError extends GetPaymentState {
  final String error;

  const GetPaymentError({required this.error});
  @override
  List<Object> get props => [error];
}
