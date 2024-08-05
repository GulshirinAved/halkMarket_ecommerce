// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';

class TopTitle extends StatelessWidget {
  final String topTitle;
  final VoidCallback? onTap;
  final bool? needArrow;
  final double topMargin;
  final double bottomMargin;

  const TopTitle({
    required this.topTitle,
    required this.topMargin,
    required this.bottomMargin,
    Key? key,
    this.onTap,
    this.needArrow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w)
            .copyWith(bottom: bottomMargin.h, top: topMargin.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //title
            Expanded(
              child: Text(
                topTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: fontExo2,
                  fontWeight: FontWeight.w700,
                  fontSize: AppFonts.fontSize20,
                  color: AppColors.darkPurpleColor,
                ),
              ),
            ),
            //right arrow icon
            needArrow == true
                ? Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightPurpleColor,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: SvgPicture.asset(
                      arrowRightIcon,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
