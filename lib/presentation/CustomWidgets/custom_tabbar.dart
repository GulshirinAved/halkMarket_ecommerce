import 'package:flutter/material.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';

class CustomTabBar extends StatelessWidget {
  final Function(int)? onTap;
  final Color? activeTextColor;
  final String leftTitle;
  final String rightTitle;
  final Color? indicatorColor;
  final double? fontSize;

  const CustomTabBar({
    required this.onTap,
    required this.leftTitle,
    required this.rightTitle,
    super.key,
    this.activeTextColor,
    this.indicatorColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      onTap: onTap,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: fontSize ?? AppFonts.fontSize12,
        color: activeTextColor ?? AppColors.whiteColor,
      ),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: fontSize ?? AppFonts.fontSize12,
        color: AppColors.darkPurpleColor,
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      indicator: BoxDecoration(
        color: indicatorColor ?? AppColors.purpleColor,
        borderRadius: AppBorders.borderRadius6,
      ),
      tabs: [
        Tab(
          text: leftTitle,
        ),
        Tab(
          text: rightTitle,
        ),
      ],
    );
  }
}
