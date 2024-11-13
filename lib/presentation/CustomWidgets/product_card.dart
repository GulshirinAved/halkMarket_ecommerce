// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/fav_button.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/cart/cartButton/cart_button_bloc.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';
import 'package:halkmarket_ecommerce/data/models/cart_model.dart';
import 'package:halkmarket_ecommerce/data/models/fav_model.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/cart/components/cartQuantity_buttons.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/smallTitle_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/productProfile_screen.dart';

class ProductCard extends StatelessWidget {
  final int index;
  final FavItem favItem;
  final CartItem cartItem;

  const ProductCard({
    required this.index,
    required this.favItem,
    required this.cartItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushScreenWithNavBar(
          context,
          ProductProfileScreen(
            cartItem: cartItem,
            favItem: favItem,
            index: index,
          ),
        );
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.grey2Color,
          borderRadius: AppBorders.borderRadius12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Stack(
              children: [
                //image

                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: 120,
                    child: cartItem.image![0] is Map<String, dynamic>
                        ? ClipRRect(
                            borderRadius: AppBorders.borderRadius12,
                            child: ExtendedImage.network(
                              '${Endpoints().url}/${favItem.image![0]['url']}',
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: AppBorders.borderRadius8,
                            child: ExtendedImage.network(
                              '${Endpoints().url}/${cartItem.image![0].url}',
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
                //favbutton
                Positioned(
                  right: 5,
                  left: 5,
                  top: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //favButton
                      FavButton(
                        favItem: favItem,
                        containerSize: 16,
                        padding: 2,
                        borderRadius: AppBorders.borderRadius4,
                      ),
                      //card for sale
                      Row(
                        children: [
                          favItem.isSale ?? false
                              ? SmallTitleCard(
                                  backColor: AppColors.blueColor,
                                  title: AppLocalization.of(context)
                                          .getTransatedValues(
                                        'sale',
                                      ) ??
                                      '',
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            width: 5,
                          ),
                          //card for new
                          favItem.isNew ?? false
                              ? SmallTitleCard(
                                  backColor: AppColors.yellowColor,
                                  title: AppLocalization.of(
                                        context,
                                      ).getTransatedValues(
                                        'new',
                                      ) ??
                                      '',
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ],
                  ),
                ),
                favItem.sugar == false
                    ? const SizedBox.shrink()
                    : Positioned(
                        bottom: 3,
                        left: 7,
                        child: RotationTransition(
                          turns: const AlwaysStoppedAnimation(-5 / 360),
                          child: SmallTitleCard(
                            title: AppLocalization.of(
                                  context,
                                ).getTransatedValues(
                                  'withoutSugar',
                                ) ??
                                '',
                            backColor: AppColors.greenColor,
                          ),
                        ),
                      ),
              ],
            ),
            //price
            Row(
              children: [
                Text(
                  '${favItem.price} TMT',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: AppFonts.fontSize15,
                    color: AppColors.darkPurpleColor,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                favItem.discount == {} ||
                        favItem.discount == null ||
                        favItem.discount!.discount == null
                    ? const SizedBox.shrink()
                    : Text(
                        '${favItem.discount?.discount} %',
                        style: TextStyle(
                          decorationColor: AppColors.redColor,
                          fontWeight: FontWeight.w400,
                          fontSize: AppFonts.fontSize10,
                          color: AppColors.redColor,
                        ),
                      ),
              ],
            ),
            //desc
            Expanded(
              child: Text(
                favItem.name ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: AppFonts.fontSize12,
                  color: AppColors.darkPurpleColor,
                ),
              ),
            ),
            //weight
            favItem.unit == null
                ? const SizedBox.shrink()
                : Text(
                    '${favItem.amount} ${favItem.unit?.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: AppFonts.fontSize10,
                      color: AppColors.grey1Color,
                    ),
                  ),
            //cart button
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: BlocBuilder<CartButtonBloc, CartButtonState>(
                  builder: (context, state) {
                    final isItemInCart =
                        state.cartList.any((item) => item?.id == cartItem.id);
                    return !isItemInCart
                        ? Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.grey3Color.withOpacity(0.35),
                                  offset: const Offset(4, 4),
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                            child: CustomButton.text(
                              width: 130,
                              backColor: AppColors.whiteColor,
                              textColor: AppColors.darkPurpleColor,
                              fontSize: AppFonts.fontSize12,
                              borderRadius: AppBorders.borderRadius8,
                              title: 'В корзину',
                              onTap: () {
                                context.read<CartButtonBloc>().add(
                                      AddCartEvent(
                                        cartItem: cartItem,
                                      ),
                                    );
                                context
                                    .read<CartButtonBloc>()
                                    .add(const LoadCartEvent());
                              },
                            ),
                          )
                        : CartQuantityButtons(
                            isCart: true,
                            cartItem: cartItem,
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
