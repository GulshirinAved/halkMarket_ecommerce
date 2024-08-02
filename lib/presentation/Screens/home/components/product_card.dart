import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/smallTitle_card.dart';

class ProductCard extends StatelessWidget {
  final int index;
  const ProductCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
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
              Positioned(
                right: 5,
                left: 5,
                top: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //favButton
                    Container(
                      height: 16.h,
                      width: 16.w,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: AppColors.lightPurpleColor,
                        borderRadius: AppBorders.borderRadius4,
                      ),
                      child: SvgPicture.asset(heartIcon),
                    ),
                    //card for sale
                    Row(
                      children: [
                        newProducts[index]['isSale']
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
                        newProducts[index]['isNew']
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
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  newProducts[index]['image'],
                ),
              ),
            ],
          ),
          //price
          Row(
            children: [
              Text(
                newProducts[index]['price'],
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: AppFonts.fontSize15,
                  color: AppColors.darkPurpleColor,
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Text(
                newProducts[index]['prevPrice'],
                style: TextStyle(
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
            newProducts[index]['desc'],
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
            '${newProducts[index]['weight']} г',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: AppFonts.fontSize10,
              color: AppColors.grey1Color,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: CustomButton(
              width: 130,
              backColor: AppColors.whiteColor,
              textColor: AppColors.darkPurpleColor,
              fontSize: AppFonts.fontSize12,
              title: 'В корзину',
            ),
          ),
        ],
      ),
    );
  }
}
