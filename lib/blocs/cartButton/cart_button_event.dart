part of 'cart_button_bloc.dart';

abstract class CartButtonEvent {}

class AddCartEvent extends CartButtonEvent {
  final CartItem cartItem;

  AddCartEvent(this.cartItem);
}

class PlusButtonEvent extends CartButtonEvent {
  final CartItem cartItem;

  PlusButtonEvent(this.cartItem);
}

class MinusButtonEvent extends CartButtonEvent {
  final CartItem cartItem;

  MinusButtonEvent(this.cartItem);
}

class RemoveCartEvent extends CartButtonEvent {
  final CartItem cartItem;

  RemoveCartEvent(this.cartItem);
}

final class RemoveCartAllEvent extends CartButtonEvent {
  RemoveCartAllEvent();
}

class SumProductEvent extends CartButtonEvent {}

class LoadCartEvent extends CartButtonEvent {}
