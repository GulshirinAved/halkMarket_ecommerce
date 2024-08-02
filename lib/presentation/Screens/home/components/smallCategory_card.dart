import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';

class SmallCategoryCard extends StatelessWidget {
  final int index;
  const SmallCategoryCard({
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 58.h,
                  width: 58.w,
                  margin: EdgeInsets.symmetric(horizontal: 6.w),
                  decoration: BoxDecoration(
                    color: AppColors.lightPurpleColor,
                    borderRadius: AppBorders.borderRadius12,
                  ),
                ),
                Positioned(
                  bottom: 1,
                  right: 8,
                  child: SvgPicture.asset(
                    smallCategories[index]['icon'],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 60.w,
              child: Text(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                smallCategories[index]['title'],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: AppFonts.fontSize10,
                  color: AppColors.darkPurpleColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
