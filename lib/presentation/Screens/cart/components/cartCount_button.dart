import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';

class CartCountButton extends StatelessWidget {
  final IconData? icon;
  const CartCountButton({
    super.key,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.w,
      width: 25.w,
      decoration: BoxDecoration(
        color: AppColors.lightPurple2Color,
        borderRadius: AppBorders.borderRadius6,
        border: Border.all(
          color: AppColors.purpleColor,
        ),
      ),
      child: Icon(
        icon,
        color: AppColors.purpleColor,
        size: 14,
      ),
    );
  }
}
