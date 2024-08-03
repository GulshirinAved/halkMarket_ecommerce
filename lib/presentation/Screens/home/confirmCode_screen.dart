import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/category/tabBar/tab_bar_cubit.dart';
import 'package:halkmarket_ecommerce/blocs/home/passwordVisibility/password_obscure_cubit.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_tabbar.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/login_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/otp_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ConfirmCodeScreen extends StatelessWidget {
  const ConfirmCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TabCubit(),
        ),
        BlocProvider(
          create: (context) => ObscureCubit(),
        ),
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: CustomAppBar.leadingTitle(
            title:
                AppLocalization.of(context).getTransatedValues('profile') ?? '',
            centerTitle: false,
            leadingWidth: 20,
            fontSize: AppFonts.fontSize15,
            textColor: AppColors.purpleColor,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //logo
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  halkMarketImage,
                  alignment: Alignment.topCenter,
                ),
              ),
              //tabbar
              Container(
                height: 47.h,
                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: AppBorders.borderRadius8,
                  color: AppColors.whiteColor,
                  border: Border.all(color: AppColors.grey5Color),
                ),
                child: BlocBuilder<TabCubit, int>(
                  builder: (context, state) {
                    return CustomTabBar(
                      onTap: (index) =>
                          context.read<TabCubit>().changeTab(index),
                      leftTitle: AppLocalization.of(context)
                              .getTransatedValues('register') ??
                          '',
                      rightTitle: AppLocalization.of(context)
                              .getTransatedValues('login') ??
                          '',
                      fontSize: AppFonts.fontSize18,
                      activeTextColor: AppColors.darkPurpleColor,
                      indicatorColor: AppColors.lightPurpleColor,
                    );
                  },
                ),
              ),
              Expanded(
                child: BlocBuilder<TabCubit, int>(
                  builder: (context, state) {
                    return IndexedStack(
                      index: state,
                      children: [
                        //!!!!!register!!!!!!!!
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //phone textfield
                                const PhoneTextField(),

                                //code apply button
                                CustomButton(
                                  width: double.infinity,
                                  backColor: AppColors.purpleColor,
                                  textColor: AppColors.whiteColor,
                                  fontSize: AppFonts.fontSize18,
                                  title: AppLocalization.of(context)
                                          .getTransatedValues('confirmCode') ??
                                      '',
                                  onTap: () {
                                    pushScreenWithNavBar(
                                      context,
                                      const OtpScreen(),
                                    );
                                  },
                                ),
                                //divider
                              ],
                            ),
                          ),
                        ),
                        // !!!!login!!!!!!!
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                const PhoneTextField(),
                                SizedBox(
                                  height: 12.h,
                                ),
                                PasswordTextField(
                                  topTitle: AppLocalization.of(context)
                                          .getTransatedValues('password') ??
                                      '',
                                  isFirst: true,
                                ),
                                Text(
                                  AppLocalization.of(context)
                                          .getTransatedValues('forgetPass') ??
                                      '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: AppFonts.fontSize16,
                                    color: AppColors.darkPurpleColor,
                                  ),
                                ),
                                CustomButton(
                                  width: double.infinity,
                                  backColor: AppColors.purpleColor,
                                  textColor: AppColors.whiteColor,
                                  fontSize: AppFonts.fontSize18,
                                  title: AppLocalization.of(context)
                                          .getTransatedValues('login') ??
                                      '',
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
