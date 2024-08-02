import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';

class TopTitle extends StatelessWidget {
  final String topTitle;
  final VoidCallback onTap;
  final bool? needArrow;
  const TopTitle({
    required this.topTitle,
    required this.onTap,
    this.needArrow = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w),
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
