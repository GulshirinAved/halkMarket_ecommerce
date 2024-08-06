import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/cartButton/cart_button_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/favButton/fav_button_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/data/models/cart_model.dart';
import 'package:halkmarket_ecommerce/data/models/fav_model.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/cart/components/cartQuantity_buttons.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/smallTitle_card.dart';

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
    return Container(
      width: 150.w,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
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
                  height: 120.h,
                  child: Image.asset(
                    favItem.image![0],
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
                    GestureDetector(
                      onTap: () => context
                          .read<FavButtonBloc>()
                          .add(ToggleFavEvent(item: favItem)),
                      child: BlocBuilder<FavButtonBloc, FavButtonState>(
                        builder: (context, state) {
                          return Container(
                            height: 16.h,
                            width: 16.w,
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: AppColors.lightPurpleColor,
                              borderRadius: AppBorders.borderRadius4,
                            ),
                            child: SvgPicture.asset(
                              state.favList.any((item) => item.id == favItem.id)
                                  ? cuteBoldHeartIcon
                                  : cuteHeartIcon,
                              colorFilter: ColorFilter.mode(
                                state.favList
                                        .any((item) => item.id == favItem.id)
                                    ? AppColors.redColor
                                    : AppColors.purpleColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          );
                        },
                      ),
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
                        SizedBox(
                          width: 5.w,
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
              favItem.withSugar == false
                  ? const SizedBox.shrink()
                  : Positioned(
                      bottom: 3.h,
                      left: 7.w,
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
              SizedBox(
                width: 8.w,
              ),
              favItem.prevPrice == null
                  ? const SizedBox.shrink()
                  : Text(
                      '${favItem.prevPrice} TMT',
                      style: TextStyle(
                        decorationColor: AppColors.redColor,
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.w400,
                        fontSize: AppFonts.fontSize10,
                        color: AppColors.redColor,
                      ),
                    ),
            ],
          ),
          //desc
          Text(
            favItem.desc ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: AppFonts.fontSize12,
              color: AppColors.darkPurpleColor,
            ),
          ),
          //weight
          Text(
            '${favItem.weight} г',
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
                      state.cartList.any((item) => item.id == cartItem.id);
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
                          child: CustomButton(
                            width: 130,
                            backColor: AppColors.whiteColor,
                            textColor: AppColors.darkPurpleColor,
                            fontSize: AppFonts.fontSize12,
                            title: 'В корзину',
                            onTap: () {
                              context
                                  .read<CartButtonBloc>()
                                  .add(AddCartEvent(cartItem));
                              context
                                  .read<CartButtonBloc>()
                                  .add(SumProductEvent());
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
    );
  }
}
