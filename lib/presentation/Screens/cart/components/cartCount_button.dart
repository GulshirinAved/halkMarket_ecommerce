import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';

class CartCountButton extends StatelessWidget {
  final IconData? icon;
  final bool? needShadow;
  final VoidCallback? onTap;
  const CartCountButton(
      {super.key, this.icon, this.needShadow = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 25.w,
        width: 25.w,
        decoration: BoxDecoration(
            color: needShadow == false
                ? AppColors.lightPurple2Color
                : AppColors.whiteColor,
            borderRadius: needShadow == false
                ? AppBorders.borderRadius6
                : AppBorders.borderRadius8,
            border: Border.all(
              color: needShadow == false
                  ? AppColors.purpleColor
                  : Colors.transparent,
            ),
            boxShadow: needShadow == false
                ? []
                : [
                    BoxShadow(
                      blurRadius: 15,
                      offset: const Offset(4, 4),
                      color: AppColors.grey3Color,
                    )
                  ]),
        child: Icon(
          icon,
          color: AppColors.purpleColor,
          size: 14,
        ),
      ),
    );
  }
}
