// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'to_order_bloc.dart';

class ToOrderEvent extends Equatable {
  final String? selectedPayment;
  final String? selectedPaymentId;
  final String? selectedDeliveryName;
  final int? selectedDeliveryPrice;
  final String? selectedDeliveryId;
  final String? selectedAddess;
  final String? until;
  final String? untilTo;
  final String? untilFrom;

  const ToOrderEvent(
    this.selectedPayment,
    this.selectedPaymentId,
    this.selectedDeliveryName,
    this.selectedDeliveryPrice,
    this.selectedDeliveryId,
    this.selectedAddess,
    this.until,
    this.untilTo,
    this.untilFrom,
  );

  @override
  List<Object> get props => [
        selectedPayment ?? '',
        selectedPaymentId ?? '',
        selectedDeliveryName ?? '',
        selectedDeliveryPrice ?? '',
        selectedDeliveryId ?? '',
        selectedAddess ?? '',
        until ?? '',
        untilTo ?? '',
        untilFrom ?? '',
      ];
}
