import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';
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
          IconButton(
            onPressed: () {},
            icon: Text(
              AppLocalization.of(context).getTransatedValues('clean') ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: AppFonts.fontSize14,
                color: AppColors.redColor,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
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
                ),
                separatorBuilder: (context, index) => Divider(
                  color: AppColors.grey5Color,
                ),
                itemCount: newProducts.length,
              ),
            ),
          ),
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
                                      .getTransatedValues(cartBill[index]) ??
                                  '',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: AppFonts.fontSize16,
                              ),
                            ),
                            Text(
                              '14',
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
      ),
    );
  }
}
