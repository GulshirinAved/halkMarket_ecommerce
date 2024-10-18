part of 'cart_button_bloc.dart';

abstract class CartButtonState extends Equatable {
  final List<CartItem?> cartList;

  const CartButtonState({required this.cartList});

  @override
  List<Object> get props => [cartList];
}

class CartButtonInitial extends CartButtonState {
  const CartButtonInitial({required super.cartList});
}

class CartButtonSuccess extends CartButtonState {
  const CartButtonSuccess({required super.cartList});
}

class SumProductState extends CartButtonState {
  const SumProductState({required super.cartList, required this.sum});

  final double sum;

  @override
  List<Object> get props => [cartList, sum];
}
