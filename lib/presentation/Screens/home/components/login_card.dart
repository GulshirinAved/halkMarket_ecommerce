import 'package:flutter/material.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(4, 4),
            blurRadius: 15,
            color: AppColors.grey3Color.withOpacity(0.35),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalization.of(context).getTransatedValues('loginAccaunt') ??
                '',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: AppFonts.fontSize18,
              color: AppColors.darkPurpleColor,
            ),
          ),
          Text(
            AppLocalization.of(context).getTransatedValues('descForLogin') ??
                '',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: AppFonts.fontSize15,
              color: AppColors.darkPurpleColor,
            ),
          ),
          CustomButton(
            width: double.infinity,
            backColor: AppColors.purpleColor,
            textColor: AppColors.whiteColor,
            fontSize: AppFonts.fontSize16,
            title: AppLocalization.of(context)
                    .getTransatedValues('loginAccaunt') ??
                '',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}