// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'to_order_bloc.dart';

class ToOrderState extends Equatable {
  final String? payment;
  final String? paymentId;
  final String? deliveryName;
  final int? deliveryPrice;
  final String? deliveryId;
  final String? selectedAddress;
  final String? until;
  final String? untilTo;
  final String? untilFrom;

  const ToOrderState(
    this.payment,
    this.deliveryName,
    this.deliveryPrice,
    this.deliveryId,
    this.paymentId,
    this.selectedAddress,
    this.until,
    this.untilTo,
    this.untilFrom,
  );

  @override
  List<Object> get props => [
        payment ?? '',
        deliveryName ?? '',
        deliveryPrice ?? 0,
        deliveryId ?? '',
        paymentId ?? '',
        selectedAddress ?? '',
        until ?? '',
        untilTo ?? '',
        untilFrom ?? '',
      ];

  ToOrderState copyWith({
    String? payment,
    String? deliveryName,
    int? deliveryPrice,
    String? deliveryId,
    String? paymentId,
    String? selectedAddress,
    String? until,
    String? untilTo,
    String? untilFrom,
  }) {
    return ToOrderState(
      payment ?? this.payment,
      deliveryName ?? this.deliveryName,
      deliveryPrice ?? this.deliveryPrice,
      deliveryId ?? this.deliveryId,
      paymentId ?? this.paymentId,
      selectedAddress ?? this.selectedAddress,
      until ?? until,
      untilTo ?? untilTo,
      untilFrom ?? untilFrom,
    );
  }
}
