import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';

class SmallTitleCard extends StatelessWidget {
  final String title;
  final Color backColor;
  const SmallTitleCard({
    required this.title,
    required this.backColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16.h,
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
        vertical: 3.w,
      ),
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: AppBorders.borderRadius4,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: AppFonts.fontSize8,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
