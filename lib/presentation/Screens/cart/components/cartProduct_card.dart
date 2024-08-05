import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/cartButton/cart_button_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/data/models/cart_model.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/cart/components/cartQuantity_buttons.dart';

class CartProductCard extends StatelessWidget {
  final int index;
  final CartItem cartItem;
  const CartProductCard({
    required this.index,
    required this.cartItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(cartItem.image![0]),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      cartItem.desc ?? '',
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: AppFonts.fontSize14,
                        color: AppColors.darkPurpleColor,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context
                          .read<CartButtonBloc>()
                          .add(RemoveCartEvent(cartItem));
                    },
                    icon: SvgPicture.asset(
                      trashIcon,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${cartItem.price} ${AppLocalization.of(context).getTransatedValues('manat')}',
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: AppFonts.fontSize16,
                      color: AppColors.darkPurpleColor,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: CartQuantityButtons(
                      cartItem: cartItem,
                      isCart: false,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
