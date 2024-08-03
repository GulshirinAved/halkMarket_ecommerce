import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';

class ProfileCard extends StatelessWidget {
  final List cardList;
  final bool? isArrow;
  const ProfileCard({
    required this.cardList,
    this.isArrow = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: AppBorders.borderRadius12,
        color: AppColors.grey2Color,
      ),
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => ListTile(
          minTileHeight: 34.h,
          leading: SvgPicture.asset(
            cardList[index]['icon'],
          ),
          title: Text(
            AppLocalization.of(context).getTransatedValues(
                  cardList[index]['title'],
                ) ??
                '',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: AppFonts.fontSize12,
              color: AppColors.darkPurpleColor,
            ),
          ),
          trailing: index == 0 && cardList == profile2Card && isArrow == false
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 12.w),
                      height: 20.h,
                      width: 1,
                      color: AppColors.grey5Color,
                    ),
                    Text(
                      'Русский',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: AppFonts.fontSize16,
                        color: AppColors.darkPurpleColor,
                      ),
                    ),
                  ],
                )
              : SvgPicture.asset(arrowRightIcon),
        ),
        separatorBuilder: (context, index) => Divider(
          color: AppColors.grey5Color,
        ),
        itemCount: cardList.length,
      ),
    );
  }
}
