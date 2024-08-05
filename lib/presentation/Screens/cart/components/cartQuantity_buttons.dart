import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/cartButton/cart_button_bloc.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/data/models/cart_model.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/cart/components/cartCount_button.dart';

class CartQuantityButtons extends StatelessWidget {
  final bool? isCart;
  final CartItem cartItem;
  const CartQuantityButtons({
    required this.cartItem,
    super.key,
    this.isCart = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CartCountButton(
          needShadow: isCart!,
          icon: CupertinoIcons.minus,
          onTap: () {
            context.read<CartButtonBloc>().add(MinusButtonEvent(cartItem));
            context.read<CartButtonBloc>().add(SumProductEvent());
          },
        ),
        BlocBuilder<CartButtonBloc, CartButtonState>(
          builder: (context, state) {
            final cartItemIndex =
                state.cartList.indexWhere((item) => item.id == cartItem.id);
            final quantity = cartItemIndex != -1
                ? state.cartList[cartItemIndex].quantity
                : 0;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                '${quantity.toString()} шт',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: AppFonts.fontSize16,
                  color: AppColors.darkPurpleColor,
                ),
              ),
            );
          },
        ),
        CartCountButton(
          needShadow: isCart!,
          icon: CupertinoIcons.plus,
          onTap: () {
            context.read<CartButtonBloc>().add(PlusButtonEvent(cartItem));
            context.read<CartButtonBloc>().add(SumProductEvent());
          },
        ),
      ],
    );
  }
}
