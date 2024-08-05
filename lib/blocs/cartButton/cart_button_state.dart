part of 'cart_button_bloc.dart';

sealed class CartButtonState extends Equatable {
  final List cartList;
  final double? sum;
  final double? salePrice;

  const CartButtonState({required this.cartList, this.sum, this.salePrice});

  @override
  List<Object> get props => [cartList, sum ?? 0, salePrice ?? 0];
}

final class CartButtonInitial extends CartButtonState {
  const CartButtonInitial({
    required super.cartList,
  });
}

final class CartButtonSuccess extends CartButtonState {
  const CartButtonSuccess({required super.cartList});

  @override
  List<Object> get props => [cartList];
}

class SumProductState extends CartButtonState {
  const SumProductState({
    required super.cartList,
    required this.sum,
  });
  @override
  final double sum;
  @override
  List<Object> get props => [
        sum,
      ];
}
