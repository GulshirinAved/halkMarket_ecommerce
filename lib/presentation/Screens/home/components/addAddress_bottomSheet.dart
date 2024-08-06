import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/map_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

Future<dynamic> addAddressBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    backgroundColor: AppColors.whiteColor,
    context: context,
    builder: (context) => Padding(
      padding:
          const EdgeInsets.all(20).copyWith(bottom: kBottomNavigationBarHeight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalization.of(context).getTransatedValues('myAddresses') ??
                    '',
                style: TextStyle(
                  fontFamily: fontExo2,
                  fontWeight: FontWeight.w700,
                  fontSize: AppFonts.fontSize18,
                  color: AppColors.darkPurpleColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  CupertinoIcons.clear,
                  color: AppColors.grey1Color,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Text(
              AppLocalization.of(context)
                      .getTransatedValues('addAddressForDelivery') ??
                  '',
              style: TextStyle(
                fontFamily: fontNunitoSans,
                fontWeight: FontWeight.w400,
                fontSize: AppFonts.fontSize15,
                color: AppColors.grey1Color,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                CupertinoIcons.add,
                color: AppColors.purpleColor,
              ),
              SizedBox(
                width: 12.w,
              ),
              Text(
                AppLocalization.of(context).getTransatedValues('addAddress') ??
                    '',
                style: TextStyle(
                  fontFamily: fontNunitoSans,
                  fontWeight: FontWeight.w400,
                  fontSize: AppFonts.fontSize15,
                  color: AppColors.darkPurpleColor,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: CustomButton(
              width: double.infinity,
              backColor: AppColors.purpleColor,
              textColor: AppColors.whiteColor,
              fontSize: AppFonts.fontSize16,
              title: AppLocalization.of(context)
                      .getTransatedValues('addAddress') ??
                  '',
              fontweight: FontWeight.w600,
              onTap: () {
                pushScreenWithoutNavBar(context, MapScreen());
              },
            ),
          ),
        ],
      ),
    ),
  );
}
