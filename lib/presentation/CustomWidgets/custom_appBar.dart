// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/category/tabBar/tab_bar_cubit.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
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
  final TextEditingController? textEditingController;
  final Function(String)? onFieldSubmitted;
  final bool? needBoxshadow;
  final String? withSubtitle;
  final bool? titleTap;
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
    this.textEditingController,
    this.onFieldSubmitted,
    this.needBoxshadow,
    this.withSubtitle,
    this.titleTap,
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
    this.textEditingController,
    this.onFieldSubmitted,
    this.needBoxshadow,
    this.withSubtitle,
    this.titleTap,
  });
  factory CustomAppBar.onlySearch({
    required TextEditingController textEditingController,
    VoidCallback? onTap,
    final Function(String)? onFieldSubmitted,
  }) {
    return CustomAppBar._(
      appBarStyle: AppBarStyle.onlySearch,
      onTap: onTap,
      textEditingController: textEditingController,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
  factory CustomAppBar.searchAndTabbar({
    required TextEditingController textEditingController,
    final Function(String)? onFieldSubmitted,
    VoidCallback? onTap,
  }) {
    return CustomAppBar._(
      appBarStyle: AppBarStyle.searchAndTabbar,
      toolBarHeight: 110,
      textEditingController: textEditingController,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
    );
  }
  factory CustomAppBar.categoryProfile({
    required String title,
    required List<Widget> actions,
    bool? needLeading,
  }) {
    return CustomAppBar._(
      appBarStyle: AppBarStyle.categoryProfile,
      leading: needLeading ?? true,
      title: title,
      actions: actions,
    );
  }
  factory CustomAppBar.searchWithLeading({
    required TextEditingController textEditingController,
    final Function(String)? onFieldSubmitted,
  }) {
    return CustomAppBar._(
      appBarStyle: AppBarStyle.searchWithLeading,
      leading: true,
      leadingWidth: 25,
      textEditingController: textEditingController,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
  factory CustomAppBar.leadingTitle({
    required String title,
    required bool centerTitle,
    double? fontSize,
    FontWeight? fontWeight,
    Color? textColor,
    double? leadingWidth,
    final VoidCallback? onTap,
    final bool? needBoxshadow,
    final List<Widget>? actions,
    final String? withSubtitle,
    final bool? titleTap,
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
      onTap: onTap,
      needBoxshadow: needBoxshadow ?? true,
      actions: actions,
      withSubtitle: withSubtitle ?? '',
      titleTap: titleTap,
    );
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle ?? true,
      toolbarHeight: toolBarHeight ?? kToolbarHeight,
      leadingWidth: leadingWidth,
      automaticallyImplyLeading: false,
      leading: leading == true
          ? IconButton(
              onPressed: onTap ??
                  () {
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
              onFieldSubmitted: onFieldSubmitted,
              controller: textEditingController,
            )
          : appBarStyle == AppBarStyle.categoryProfile ||
                  appBarStyle == AppBarStyle.leadingTitle &&
                      withSubtitle!.isEmpty
              ? titleTap != null
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        title ?? '',
                        style: TextStyle(
                          fontFamily: fontExo2,
                          fontWeight: fontweight ?? FontWeight.w600,
                          fontSize: fontSize ?? AppFonts.fontSize20,
                          color: textColor ?? AppColors.darkPurpleColor,
                        ),
                      ),
                    )
                  : Text(
                      title ?? '',
                      style: TextStyle(
                        fontFamily: fontExo2,
                        fontWeight: fontweight ?? FontWeight.w600,
                        fontSize: fontSize ?? AppFonts.fontSize20,
                        color: textColor ?? AppColors.darkPurpleColor,
                      ),
                    )
              //I did it for chat
              : appBarStyle == AppBarStyle.leadingTitle &&
                          withSubtitle != null ||
                      withSubtitle!.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.grey5Color,
                                ),
                              ),
                              child: Image.asset(
                                halkMarketImage,
                                height: 28,
                                width: 28,
                              ),
                            ),
                            Positioned(
                              left: 35,
                              top: 5,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.green1Color,
                                  shape: BoxShape.circle,
                                ),
                                height: 6,
                                width: 6,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title ?? '',
                              style: TextStyle(
                                fontFamily: fontNunitoSans,
                                fontWeight: FontWeight.w600,
                                fontSize: AppFonts.fontSize16,
                                color: AppColors.darkPurpleColor,
                              ),
                            ),
                            Text(
                              withSubtitle ?? '',
                              style: TextStyle(
                                fontFamily: fontNunitoSans,
                                fontWeight: FontWeight.w400,
                                fontSize: AppFonts.fontSize12,
                                color: AppColors.grey1Color,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : null,
      actions: actions,
      flexibleSpace: appBarStyle == AppBarStyle.searchAndTabbar ||
              appBarStyle == AppBarStyle.categoryProfile ||
              appBarStyle == AppBarStyle.leadingTitle && needBoxshadow == true
          ? Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: AppColors.grey3Color.withOpacity(0.35),
                    offset: const Offset(2, 1),
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
                margin:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
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
