import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';

class SubCategoryChip extends StatelessWidget {
  final selectState;
  final oneProductState;
  final int? index;
  final bool? withIcon;
  final VoidCallback? onTap;
  const SubCategoryChip({
    super.key,
    this.selectState,
    this.oneProductState,
    this.index,
    this.withIcon = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          right: 6,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: withIcon == true ? 6 : 12,
          vertical: withIcon == true ? 3 : 5,
        ),
        decoration: BoxDecoration(
          color: withIcon == true
              ? AppColors.lightPurpleColor
              : selectState?.index == index
                  ? AppColors.purpleColor
                  : AppColors.lightPurpleColor,
          borderRadius: AppBorders.borderRadius8,
        ),
        child: withIcon == true
            ? SvgPicture.asset(
                menuIcon,
                height: 20,
              )
            : Text(
                oneProductState
                        ?.getOneCatalogeList.subcategories?[index].name ??
                    '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: AppFonts.fontSize12,
                  color: selectState?.index == index
                      ? AppColors.whiteColor
                      : AppColors.darkPurpleColor,
                ),
              ),
      ),
    );
  }
}
