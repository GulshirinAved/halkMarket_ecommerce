import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_textField.dart';

class FollowCard extends StatelessWidget {
  const FollowCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      padding: EdgeInsets.symmetric(
        vertical: 29.h,
        horizontal: 16.w,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.purpleColor,
            AppColors.lightPurple1Color,
          ],
        ),
        borderRadius: AppBorders.borderRadius16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //desc
          Text(
            'Подпишитесь на нас и узнавайте обо всем первыми!',
            style: TextStyle(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w800,
              fontSize: AppFonts.fontSize16,
            ),
          ),
          //deep desc
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Мы постоянно расширяем ассортимент нашей продукции. Подпишитесь на нас, и мы подарим вам промокод на заказ в нашем маркеде',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w400,
                fontSize: AppFonts.fontSize10,
              ),
            ),
          ),
          Row(
            children: [
              //textfield
              Expanded(
                child: Container(
                  height: 37,
                  margin: EdgeInsets.only(right: 6.w),
                  child: CustomTextField.normal(hinText: 'Введите почту'),
                ),
              ),
              //follow button
              CustomButton(
                width: 88,
                backColor: AppColors.whiteColor,
                textColor: AppColors.darkPurpleColor,
                fontSize: AppFonts.fontSize10,
                title: 'Подписаться',
                fontweight: FontWeight.w700,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
