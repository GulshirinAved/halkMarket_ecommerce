import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/cart/cartButton/cart_button_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';

import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';
import 'package:halkmarket_ecommerce/data/models/cart_model.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/cart/components/cartQuantity_buttons.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_dialog.dart';

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
    return Dismissible(
      key: ValueKey(cartItem.id),
      background: Container(
        color: AppColors.redColor,
        width: 50,
        padding: const EdgeInsets.symmetric(horizontal: 21),
        alignment: Alignment.centerRight,
        child: SvgPicture.asset(
          trashIcon,
          fit: BoxFit.scaleDown,
          colorFilter: ColorFilter.mode(AppColors.whiteColor, BlendMode.srcIn),
        ),
      ),
      secondaryBackground: Container(
        width: 50,
        color: AppColors.redColor,
        padding: const EdgeInsets.symmetric(horizontal: 21),
        alignment: Alignment.centerRight,
        child: SvgPicture.asset(
          trashIcon,
          fit: BoxFit.scaleDown,
          colorFilter: ColorFilter.mode(AppColors.whiteColor, BlendMode.srcIn),
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          return await customDialog(
            context,
            subTitle: AppLocalization.of(context)
                    .getTransatedValues('sureToDelete') ??
                '',
            rightOnTap: () {
              context.read<CartButtonBloc>().add(
                    CartUpdateEvent(
                      cartItem: cartItem,
                      action: CartAction.remove,
                    ),
                  );
            },
          );
        }
        return null;
      },
      child: Container(
        padding: const EdgeInsets.only(top: 20, bottom: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.grey5Color),
          ),
        ),
        child: Row(
          children: [
            cartItem.image![0] is Map<String, dynamic>
                ? ClipRRect(
                    borderRadius: AppBorders.borderRadius8,
                    child: ExtendedImage.network(
                      '${Endpoints().url}/${cartItem.image![0]['url']!}',
                      height: 57,
                      width: 57,
                      fit: BoxFit.cover,
                    ),
                  )
                : ClipRRect(
                    borderRadius: AppBorders.borderRadius8,
                    child: ExtendedImage.network(
                      '${Endpoints().url}/${cartItem.image![0].url}',
                      height: 57,
                      width: 57,
                      fit: BoxFit.cover,
                    ),
                  ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.desc ?? '',
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: AppFonts.fontSize14,
                      color: AppColors.darkPurpleColor,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${cartItem.price} ${AppLocalization.of(context).getTransatedValues('manat')}',
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
        ),
      ),
    );
  }
}
