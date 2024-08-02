import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';

class TopTitle extends StatelessWidget {
  final String topTitle;
  const TopTitle({
    required this.topTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //title
          Text(
            topTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: AppFonts.fontSize20,
              color: AppColors.darkPurpleColor,
            ),
          ),
          //right arrow icon
          Container(
            decoration: BoxDecoration(
              color: AppColors.lightPurpleColor,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(4),
            child: SvgPicture.asset(
              arrowRightIcon,
            ),
          ),
        ],
      ),
    );
  }
}
