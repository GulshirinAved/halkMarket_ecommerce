import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/data/api_providers/auth_provider.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/basket_repository.dart';
import 'package:halkmarket_ecommerce/data/models/cart_model.dart';
import 'package:hive/hive.dart';

part 'cart_button_event.dart';
part 'cart_button_state.dart';

enum CartAction { add, increaseQuantity, decreaseQuantity, remove }

class CartButtonBloc extends Bloc<CartButtonEvent, CartButtonState> {
  final Box box = Hive.box('cartBox');
  String? token = AuthProvider().getAccessToken();
  final BasketRepository basketRepository = BasketRepository();

  CartButtonBloc() : super(const CartButtonInitial(cartList: [])) {
    on<AddCartEvent>((event, emit) async {
      final updatedList = List<CartItem>.from(state.cartList)
        ..add(event.cartItem);
      await box.put(
        'cartList',
        updatedList.map((item) => item.toJson()).toList(),
      );
      emit(
        SumProductState(
          cartList: updatedList,
          sum: _calculateSum(updatedList),
        ),
      );

      if (token != null && token!.isNotEmpty) {
        await _updateBasket(cartItem: event.cartItem, action: CartAction.add);
      }
    });

    on<CartUpdateEvent>((event, emit) async {
      final updatedList = List<CartItem>.from(state.cartList);
      final cartItem = event.cartItem;

      switch (event.action) {
        case CartAction.increaseQuantity:
          final existingIndex =
              updatedList.indexWhere((item) => item.id == cartItem.id);
          if (existingIndex != -1) {
            updatedList[existingIndex] = updatedList[existingIndex].copyWith(
              quantity: updatedList[existingIndex].quantity + 1,
            );
          }
          break;
        case CartAction.decreaseQuantity:
          final existingIndex =
              updatedList.indexWhere((item) => item.id == cartItem.id);
          if (existingIndex != -1) {
            if (updatedList[existingIndex].quantity > 1) {
              updatedList[existingIndex] = updatedList[existingIndex].copyWith(
                quantity: updatedList[existingIndex].quantity - 1,
              );
            } else {
              updatedList.removeAt(existingIndex);
            }
          }
          break;
        case CartAction.remove:
          updatedList.removeWhere((item) => item.id == cartItem.id);
          break;
        default:
      }

      await box.put(
        'cartList',
        updatedList.map((item) => item.toJson()).toList(),
      );
      emit(
        SumProductState(
          cartList: updatedList,
          sum: _calculateSum(updatedList),
        ),
      );

      if (token != null && token!.isNotEmpty) {
        await _updateBasket(cartItem: cartItem, action: event.action);
      }
    });

    on<RemoveCartEvent>((event, emit) async {
      final updatedList = List<CartItem>.from(state.cartList)
        ..removeWhere((item) => item.id == event.cartItem.id);
      await box.put(
        'cartList',
        updatedList.map((item) => item.toJson()).toList(),
      );
      emit(
        SumProductState(
          cartList: updatedList,
          sum: _calculateSum(updatedList),
        ),
      );

      if (token != null && token!.isNotEmpty) {
        await _updateBasket(
          cartItem: event.cartItem,
          action: CartAction.remove,
        );
      }
    });

    on<RemoveCartAllEvent>((event, emit) async {
      await box.clear();
      emit(const CartButtonSuccess(cartList: []));
      if (token != null && token!.isNotEmpty) {
        await basketRepository.removeAllProduct();
      }
    });

    on<LoadCartEvent>((event, emit) {
      final loadedList = (box.get('cartList', defaultValue: []) as List)
          .map((item) => CartItem.fromJson(item))
          .toList();
      final sum = _calculateSum(loadedList);
      emit(SumProductState(cartList: loadedList, sum: sum));
    });
  }

  double _calculateSum(List<CartItem> cartList) {
    double sum = 0;
    for (var item in cartList) {
      sum += (item.price ?? 0) * item.quantity;
    }
    return sum;
  }

  Future<void> _updateBasket({
    required CartItem cartItem,
    required CartAction action,
  }) async {
    try {
      switch (action) {
        case CartAction.add:
          final success = await basketRepository.addBasket(
            id: '',
            productId: cartItem.id,
            quantity: cartItem.quantity,
          );
          if (!success) {}
          break;
        case CartAction.increaseQuantity:
          final success = await basketRepository.addBasket(
            id: '',
            productId: cartItem.id,
            quantity: cartItem.quantity + 1,
          );
          if (!success) {}
          break;
        case CartAction.decreaseQuantity:
          final success = await basketRepository.removeProduct(id: cartItem.id);
          if (!success) {}
          break;
        case CartAction.remove:
          final success = await basketRepository.removeProduct(id: cartItem.id);
          if (!success) {}
          break;
        default:
      }
    } catch (e) {
      print('Error updating basket: $e');
    }
  }
}
