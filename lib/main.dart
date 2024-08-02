import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/bottomNavBar/bottomNavBar_screen.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      ensureScreenSize: true,
      minTextAdapt: true,
      child: MaterialApp(
        title: 'Halk Market',
        theme: ThemeData(
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
          appBarTheme: AppBarTheme(
            surfaceTintColor: AppColors.whiteColor,
            backgroundColor: AppColors.whiteColor,
          ),
        ),
        home: const BottomNavBar(),
        debugShowCheckedModeBanner: false,
        builder: (context, child) => MediaQuery(
          data:
              MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          child: child!,
        ),
        locale: const Locale('ru'),
        supportedLocales: const [
          Locale('ru'),
          Locale('tr'),
        ],
        localizationsDelegates: const [
          AppLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          for (var locale in supportedLocales) {
            if (deviceLocale != null) {
              if (deviceLocale.languageCode == locale.languageCode) {
                return deviceLocale;
              }
            }
          }
          return supportedLocales.first;
        },
      ),
    ),
  );
}
