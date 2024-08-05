import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/language/language_bloc.dart';

import 'package:halkmarket_ecommerce/config/theme/theme.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/bottomNavBar/bottomNavBar_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('favBox');
  await Hive.openBox('cartBox');
  await Hive.openBox('lang');
  runApp(
    BlocProvider(
      create: (context) => LanguageBloc()..add(InitialLanguageEvent()),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        ensureScreenSize: true,
        minTextAdapt: true,
        child: BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, state) {
            String? locale;
            if (state is ChangeLanguageState) {
              locale = state.languageCode;
            }

            return MaterialApp(
              title: 'Halk Market',
              themeAnimationCurve: Curves.easeInOut,
              home: const BottomNavBar(),
              debugShowCheckedModeBanner: false,
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.noScaling),
                child: child!,
              ),
              locale: Locale(locale ?? 'tr'),
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
              theme: lightTheme(),
            );
          },
        ),
      ),
    ),
  );
}
