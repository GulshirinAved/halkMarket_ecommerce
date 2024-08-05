import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/cartButton/cart_button_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/data/models/cart_model.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/cart/components/cartProduct_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.categoryProfile(
        title: AppLocalization.of(context).getTransatedValues('cart') ?? '',
        needLeading: false,
        actions: [
          BlocBuilder<CartButtonBloc, CartButtonState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  context.read<CartButtonBloc>().add(RemoveCartAllEvent());
                },
                icon: Text(
                  AppLocalization.of(context).getTransatedValues('clean') ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: AppFonts.fontSize14,
                    color: state.cartList.isEmpty
                        ? AppColors.grey5Color
                        : AppColors.redColor,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CartButtonBloc, CartButtonState>(
        builder: (context, state) {
          if (state is CartButtonInitial || state.cartList.isEmpty) {
            return const Center(
              child: Text('There is no product'),
            );
          }
          return Column(
            children: [
              ///products
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                  ),
                  margin: const EdgeInsets.all(10),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => CartProductCard(
                      index: index,
                      cartItem: CartItem(
                        id: state.cartList[index].id,
                        isNew: state.cartList[index].isNew,
                        isSale: state.cartList[index].isSale,
                        image: state.cartList[index].image,
                        price: state.cartList[index].price,
                        prevPrice: state.cartList[index].prevPrice,
                        desc: state.cartList[index].desc,
                        weight: state.cartList[index].weight,
                      ),
                    ),
                    separatorBuilder: (context, index) => Divider(
                      color: AppColors.grey5Color,
                    ),
                    itemCount: state.cartList.length,
                  ),
                ),
              ),
              //price card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: AppBorders.borderRadius16,
                  color: AppColors.lightPurpleColor,
                  border: Border.all(
                    color: AppColors.grey5Color,
                  ),
                ),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => index == 0
                          ? Text(
                              AppLocalization.of(context)
                                      .getTransatedValues(cartBill[index]) ??
                                  '',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: AppFonts.fontSize18,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalization.of(context)
                                          .getTransatedValues(
                                        cartBill[index],
                                      ) ??
                                      '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: AppFonts.fontSize16,
                                  ),
                                ),
                                Text(
                                  _getRowValue(index, state),
                                  style: TextStyle(
                                    fontWeight: index == 5
                                        ? FontWeight.w800
                                        : FontWeight.w600,
                                    fontSize: AppFonts.fontSize16,
                                  ),
                                ),
                              ],
                            ),
                      separatorBuilder: (context, index) => Divider(
                        color: AppColors.grey5Color,
                      ),
                      itemCount: 6,
                    ),
                    CustomButton(
                      width: double.infinity,
                      backColor: AppColors.purpleColor,
                      textColor: AppColors.whiteColor,
                      fontSize: AppFonts.fontSize16,
                      fontweight: FontWeight.w600,
                      title: AppLocalization.of(context)
                              .getTransatedValues('orderReady') ??
                          '',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _getRowValue(int index, state) {
    switch (index) {
      case 1:
        return state.cartList.length.toString();
      case 2:
        return state.sum.toString();
      case 3:
        return '20';
      case 4:
        return state.salePrice.toString();
      case 5:
        return '${state.sum! + 20.0}';
      default:
        return '';
    }
  }
}
