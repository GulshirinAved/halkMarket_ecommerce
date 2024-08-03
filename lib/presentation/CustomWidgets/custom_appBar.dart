// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/category/tabBar/tab_bar_cubit.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_tabbar.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_textField.dart';

enum AppBarStyle {
  onlySearch,
  searchAndTabbar,
  categoryProfile,
  searchWithLeading,
  leadingTitle,
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBarStyle appBarStyle;
  final double? toolBarHeight;
  final bool? leading;
  final String? title;
  final List<Widget>? actions;
  final double? leadingWidth;
  final bool? centerTitle;
  final double? fontSize;
  final FontWeight? fontweight;
  final Color? textColor;
  final VoidCallback? onTap;
  const CustomAppBar({
    required this.appBarStyle,
    this.toolBarHeight,
    this.leading = false,
    this.title,
    this.actions,
    this.leadingWidth,
    this.centerTitle,
    this.fontSize,
    this.fontweight,
    this.textColor,
    this.onTap,
    super.key,
  });
  const CustomAppBar._({
    required this.appBarStyle,
    this.toolBarHeight,
    this.leading = false,
    this.title,
    this.actions,
    this.leadingWidth,
    this.centerTitle,
    this.fontSize,
    this.fontweight,
    this.textColor,
    this.onTap,
  });
  factory CustomAppBar.onlySearch({VoidCallback? onTap}) {
    return CustomAppBar._(
      appBarStyle: AppBarStyle.onlySearch,
      onTap: onTap,
    );
  }
  factory CustomAppBar.searchAndTabbar() {
    return CustomAppBar._(
      appBarStyle: AppBarStyle.searchAndTabbar,
      toolBarHeight: 110.h,
    );
  }
  factory CustomAppBar.categoryProfile(
      {required String title,
      required List<Widget> actions,
      bool? needLeading}) {
    return CustomAppBar._(
      appBarStyle: AppBarStyle.categoryProfile,
      leading: needLeading ?? true,
      title: title,
      actions: actions,
    );
  }
  factory CustomAppBar.searchWithLeading() {
    return const CustomAppBar._(
      appBarStyle: AppBarStyle.searchWithLeading,
      leading: true,
      leadingWidth: 25,
    );
  }
  factory CustomAppBar.leadingTitle({
    required String title,
    required bool centerTitle,
    double? fontSize,
    FontWeight? fontWeight,
    Color? textColor,
    double? leadingWidth,
  }) {
    return CustomAppBar._(
      appBarStyle: AppBarStyle.leadingTitle,
      leading: true,
      title: title,
      centerTitle: centerTitle,
      fontSize: fontSize,
      fontweight: fontWeight,
      textColor: textColor,
      leadingWidth: leadingWidth,
    );
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle ?? true,
      toolbarHeight: toolBarHeight ?? kToolbarHeight,
      leadingWidth: leadingWidth,
      leading: leading == true
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.keyboard_arrow_left,
              ),
            )
          : null,
      title: appBarStyle == AppBarStyle.onlySearch ||
              appBarStyle == AppBarStyle.searchAndTabbar ||
              appBarStyle == AppBarStyle.searchWithLeading
          ? CustomTextField.search(
              context: context,
              onTap: onTap,
            )
          : appBarStyle == AppBarStyle.categoryProfile ||
                  appBarStyle == AppBarStyle.leadingTitle
              ? Text(
                  title ?? '',
                  style: TextStyle(
                    fontWeight: fontweight ?? FontWeight.w600,
                    fontSize: fontSize ?? AppFonts.fontSize20,
                    color: textColor ?? AppColors.darkPurpleColor,
                  ),
                )
              : null,
      actions: actions,
      flexibleSpace: appBarStyle == AppBarStyle.searchAndTabbar ||
              appBarStyle == AppBarStyle.categoryProfile
          ? Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: AppColors.grey4Color.withOpacity(0.55),
                    offset: const Offset(4, 4),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            )
          : null,
      bottom: appBarStyle == AppBarStyle.searchAndTabbar
          ? PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: Container(
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: AppBorders.borderRadius8,
                  color: AppColors.lightPurpleColor,
                ),
                child: BlocBuilder<TabCubit, int>(
                  builder: (context, state) {
                    return CustomTabBar(
                      onTap: (index) =>
                          context.read<TabCubit>().changeTab(index),
                      leftTitle: AppLocalization.of(context)
                              .getTransatedValues('catalog') ??
                          '',
                      rightTitle: AppLocalization.of(context)
                              .getTransatedValues('brands') ??
                          '',
                    );
                  },
                ),
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolBarHeight ?? kToolbarHeight);
}
