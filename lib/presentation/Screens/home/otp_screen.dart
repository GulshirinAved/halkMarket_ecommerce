import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_textField.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.leadingTitle(
          title:
              AppLocalization.of(context).getTransatedValues('profile') ?? '',
          centerTitle: false,
          leadingWidth: 20,
          fontSize: AppFonts.fontSize15,
          textColor: AppColors.purpleColor,
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Image.asset(
            halkMarketImage,
            alignment: Alignment.topCenter,
          ),
          Text(
            AppLocalization.of(context).getTransatedValues('writeCode') ?? '',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: AppFonts.fontSize24,
              color: AppColors.darkPurpleColor,
            ),
          ),
          Text(
            '${AppLocalization.of(context).getTransatedValues('descWriteCode') ?? ''} +993 64 20 00 48',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: AppFonts.fontSize15,
              color: AppColors.darkPurpleColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 56.w,
                height: 50.h,
                margin: EdgeInsets.only(right: 11.w, top: 10.w),
                child: CustomTextField.normal(
                  hinText: '',
                  needPrefix: 2,
                ),
              ),
              Container(
                width: 56.w,
                height: 50.h,
                margin: EdgeInsets.only(right: 11.w, top: 10.w),
                child: CustomTextField.normal(
                  hinText: '',
                  needPrefix: 2,
                ),
              ),
              Container(
                width: 56.w,
                height: 50.h,
                margin: EdgeInsets.only(right: 11.w, top: 10.w),
                child: CustomTextField.normal(
                  hinText: '',
                  needPrefix: 2,
                ),
              ),
              Container(
                width: 56.w,
                height: 50.h,
                margin: EdgeInsets.only(right: 11.w, top: 10.w),
                child: CustomTextField.normal(
                  hinText: '',
                  needPrefix: 2,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              width: double.infinity,
              backColor: AppColors.purpleColor,
              textColor: AppColors.whiteColor,
              fontSize: AppFonts.fontSize18,
              title: AppLocalization.of(context)
                      .getTransatedValues('confirmCode') ??
                  '',
              onTap: () {},
            ),
          ),
          Text.rich(
            maxLines: 2,
            TextSpan(
              children: [
                TextSpan(
                  text: AppLocalization.of(context)
                          .getTransatedValues('resend') ??
                      '',
                  style: TextStyle(
                    color: AppColors.darkPurpleColor,
                    fontWeight: FontWeight.w400,
                    fontSize: AppFonts.fontSize14,
                  ),
                ),
                TextSpan(
                  text: '00:40',
                  style: TextStyle(
                    color: AppColors.purpleColor,
                    fontWeight: FontWeight.w400,
                    fontSize: AppFonts.fontSize14,
                  ),
                ),
              ],
            ),
          )
        ]));
  }
}
