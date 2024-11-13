import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/cart/cartButton/cart_button_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/cart/expandCartPrice/expand_cart_price_cubit.dart';

import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/cart/cart_screen.dart';

class CartPriceBottomSheet extends StatelessWidget {
  final state;
  final int deliveryPrice;
  final VoidCallback onTap;
  final num? padding;
  const CartPriceBottomSheet({
    required this.state,
    required this.deliveryPrice,
    required this.onTap,
    super.key,
    this.padding = 0,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final isSmallScreen = screenHeight < 700;
    return BlocBuilder<CartButtonBloc, CartButtonState>(
      builder: (context, state) {
        double sum = 0.0;
        if (state is SumProductState) {
          sum = state.sum;
        }
        return Align(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            child: Container(
              width: screenWidth,
              padding: EdgeInsets.only(
                bottom: kBottomNavigationBarHeight + padding! + bottomInset,
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: AppBorders.borderRadius20,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    color: AppColors.grey6Color.withOpacity(0.35),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Your discount notification and expand/collapse sections here
                  if (sum < 100.0)
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: isSmallScreen ? 4 : 6,
                        horizontal: screenWidth * 0.05,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: isSmallScreen ? 8 : 10,
                        horizontal: screenWidth * 0.03,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightPurple2Color,
                        borderRadius: AppBorders.borderRadius12,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalization.of(context).locale == 'ru'
                            ? 'При добавлении товара в корзину еще на ${100.0 - sum} ман. услуга доставки бесплатная!'
                            : 'Ýene ${100.0 - sum} manatdan geçseniz,eltip bermek hyzmaty mugt!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: AppFonts.fontSize14,
                          color: AppColors.darkPurpleColor,
                        ),
                      ),
                    ),

                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    decoration: BoxDecoration(
                      color: AppColors.lightPurple2Color,
                      borderRadius: AppBorders.borderRadius20,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Expand/collapse icon button and expanding section
                        IconButton(
                          onPressed: () {
                            context.read<ExpandCartPriceCubit>().toggleExpand();
                          },
                          icon: BlocBuilder<ExpandCartPriceCubit, bool>(
                            builder: (context, expanded) {
                              return SvgPicture.asset(
                                expanded ? arrowDownIcon : arrowUpIcon,
                              );
                            },
                          ),
                        ),
                        BlocBuilder<ExpandCartPriceCubit, bool>(
                          builder: (context, expanded) {
                            return expanded
                                ? Flexible(
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalization.of(context)
                                                    .getTransatedValues(
                                                  cartBill[index],
                                                ) ??
                                                '',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: AppFonts.fontSize12,
                                              color: AppColors.darkPurpleColor,
                                            ),
                                          ),
                                          Text(
                                            _getRowValue(
                                              context,
                                              index,
                                              state,
                                              deliveryPrice,
                                            ),
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: AppFonts.fontSize14,
                                              color: AppColors.darkPurpleColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      separatorBuilder: (context, index) {
                                        return Divider(
                                          color: AppColors.grey5Color,
                                        );
                                      },
                                      itemCount: cartBill.length,
                                    ),
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                        ReadyOrderButton(
                          onTap: onTap,
                          sumPrice: '${sum + deliveryPrice}',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

String _getRowValue(context, int index, state, deliveryPrice) {
  switch (index) {
    case 0:
      return state.cartList.length.toString();
    case 1:
      return '${state is SumProductState ? state.sum : 0} ${AppLocalization.of(context).getTransatedValues('manat')}';
    case 2:
      return '$deliveryPrice ${AppLocalization.of(context).getTransatedValues('manat')}';

    default:
      return '';
  }
}
