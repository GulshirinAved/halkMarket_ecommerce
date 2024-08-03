// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/category/tabBar/tab_bar_cubit.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_textField.dart';

enum AppBarStyle {
  onlySearch,
  searchAndTabbar,
  categoryProfile,
  searchWithLeading
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBarStyle appBarStyle;
  final double? toolBarHeight;
  final bool? leading;
  final String? title;
  final List<Widget>? actions;
  final double? leadingWidth;
  const CustomAppBar({
    required this.appBarStyle,
    this.toolBarHeight,
    this.leading = false,
    this.title,
    this.actions,
    this.leadingWidth,
    super.key,
  });
  const CustomAppBar._({
    required this.appBarStyle,
    this.toolBarHeight,
    this.leading = false,
    this.title,
    this.actions,
    this.leadingWidth,
  });
  factory CustomAppBar.onlySearch() {
    return const CustomAppBar._(
      appBarStyle: AppBarStyle.onlySearch,
    );
  }
  factory CustomAppBar.searchAndTabbar() {
    return CustomAppBar._(
      appBarStyle: AppBarStyle.searchAndTabbar,
      toolBarHeight: 110.h,
    );
  }
  factory CustomAppBar.categoryProfile(
      {required String title, required List<Widget> actions}) {
    return CustomAppBar._(
      appBarStyle: AppBarStyle.categoryProfile,
      leading: true,
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
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
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
          ? CustomTextField.search(context: context)
          : appBarStyle == AppBarStyle.categoryProfile
              ? Text(
                  title ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: AppFonts.fontSize20,
                    color: AppColors.darkPurpleColor,
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
                    return TabBar(
                      onTap: (index) =>
                          context.read<TabCubit>().changeTab(index),
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: AppFonts.fontSize12,
                        color: AppColors.whiteColor,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: AppFonts.fontSize12,
                        color: AppColors.darkPurpleColor,
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        color: AppColors.purpleColor,
                        borderRadius: AppBorders.borderRadius6,
                      ),
                      tabs: [
                        Tab(
                          text: AppLocalization.of(context)
                              .getTransatedValues('catalog'),
                        ),
                        Tab(
                          text: AppLocalization.of(context)
                              .getTransatedValues('brands'),
                        ),
                      ],
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
