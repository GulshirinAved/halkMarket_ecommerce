import 'package:flutter/material.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';

ThemeData lightTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.whiteColor,
    ),
    useMaterial3: true,
    fontFamily: fontNunitoSans,
    scaffoldBackgroundColor: AppColors.whiteColor,
    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.whiteColor,
    ),
    dividerTheme: DividerThemeData(color: AppColors.grey5Color),
    radioTheme: RadioThemeData(
      fillColor: WidgetStatePropertyAll(
        AppColors.darkPurpleColor,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStatePropertyAll(AppColors.whiteColor),
      overlayColor: WidgetStatePropertyAll(
        AppColors.purpleColor,
      ),
    ),
    appBarTheme: AppBarTheme(
      surfaceTintColor: AppColors.whiteColor,
      backgroundColor: AppColors.whiteColor,
    ),
  );
}
