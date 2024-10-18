part of 'cart_button_bloc.dart';

abstract class CartButtonEvent extends Equatable {
  const CartButtonEvent();

  @override
  List<Object> get props => [];
}

class AddCartEvent extends CartButtonEvent {
  const AddCartEvent({required this.cartItem});

  final CartItem cartItem;

  @override
  List<Object> get props => [cartItem];
}

class CartUpdateEvent extends CartButtonEvent {
  const CartUpdateEvent({required this.cartItem, required this.action});

  final CartItem cartItem;
  final CartAction action;

  @override
  List<Object> get props => [cartItem, action];
}

class RemoveCartEvent extends CartButtonEvent {
  const RemoveCartEvent({required this.cartItem});

  final CartItem cartItem;

  @override
  List<Object> get props => [cartItem];
}

class RemoveCartAllEvent extends CartButtonEvent {
  const RemoveCartAllEvent();
}

class LoadCartEvent extends CartButtonEvent {
  const LoadCartEvent();
}
