import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/category/tabBar/tab_bar_cubit.dart';
import 'package:halkmarket_ecommerce/blocs/home/passwordVisibility/password_obscure_cubit.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_tabbar.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_textField.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/confirmCode_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                                PasswordTextField(
                                  topTitle: AppLocalization.of(context)
                                          .getTransatedValues('password') ??
                                      '',
                                  isFirst: true,
                                ),
                                //pass textfiel
                                PasswordTextField(
                                  topTitle: AppLocalization.of(context)
                                          .getTransatedValues('confirmPass') ??
                                      '',
                                  isFirst: false,
                                ),
                                //desc
                                Container(
                                  margin:
                                      EdgeInsets.only(top: 12.h, bottom: 15.h),
                                  child: Text(
                                    'SMS код отправлен на ваш телефон',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: AppFonts.fontSize16,
                                      color: AppColors.darkPurpleColor,
                                    ),
                                  ),
                                ),
                                //register button
                                CustomButton(
                                  width: double.infinity,
                                  backColor: AppColors.purpleColor,
                                  textColor: AppColors.whiteColor,
                                  fontSize: AppFonts.fontSize18,
                                  title: AppLocalization.of(context)
                                          .getTransatedValues('register') ??
                                      '',
                                  onTap: () {
                                    pushScreenWithNavBar(
                                        context, const ConfirmCodeScreen());
                                  },
                                ),
                                //divider
                                dividerOr(context),
                                // help of google or apple button
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    iconButton(icon: googleIcon),
                                    iconButton(icon: appleIcon),
                                  ],
                                ),
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
                                dividerOr(context),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    iconButton(icon: googleIcon),
                                    iconButton(icon: appleIcon),
                                  ],
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

  Container dividerOr(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 25.h),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: AppColors.lightPurpleColor,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 30.w,
            ),
            child: Text(
              AppLocalization.of(context).getTransatedValues('or') ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: AppFonts.fontSize16,
                color: AppColors.darkPurpleColor,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: AppColors.lightPurpleColor,
            ),
          ),
        ],
      ),
    );
  }
}

Container iconButton({required String icon}) {
  return Container(
    height: 44.h,
    width: 44.w,
    decoration: BoxDecoration(
      borderRadius: AppBorders.borderRadius12,
      border: Border.all(
        color: AppColors.purpleColor,
      ),
    ),
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.all(5),
    child: SvgPicture.asset(
      icon,
    ),
  );
}

class PasswordTextField extends StatelessWidget {
  final String topTitle;
  final bool isFirst;
  const PasswordTextField({
    required this.topTitle,
    required this.isFirst,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          topTitle,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: AppFonts.fontSize16,
            color: AppColors.grey1Color,
          ),
        ),
        BlocBuilder<ObscureCubit, ObscureState>(
          builder: (context, state) {
            return CustomTextField.normal(
              hinText: '',
              needPrefix: 2,
              backColor: AppColors.whiteColor,
              nonActiveBorderColor: AppColors.grey5Color,
              borderColor: AppColors.grey5Color,
              isObscure: isFirst
                  ? state.isPasswordObscured
                  : state.isConfirmPasswordObscured,
              suffixWidget: IconButton(
                onPressed: () {
                  isFirst
                      ? context.read<ObscureCubit>().togglePasswordObscure()
                      : context
                          .read<ObscureCubit>()
                          .toggleConfirmPasswordObscure();
                },
                icon: SvgPicture.asset(
                  isFirst
                      ? state.isPasswordObscured
                          ? eyeOffIcon
                          : eyeIcon
                      : state.isConfirmPasswordObscured
                          ? eyeOffIcon
                          : eyeIcon,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalization.of(context).getTransatedValues('phone') ?? '',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: AppFonts.fontSize16,
            color: AppColors.grey1Color,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: AppBorders.borderRadius12,
            border: Border.all(color: AppColors.grey5Color),
          ),
          child: Row(
            children: [
              Text(
                ' +993 | ',
                style: TextStyle(
                  color: AppColors.darkPurpleColor,
                  fontSize: AppFonts.fontSize18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(
                child: CustomTextField.normal(
                  hinText: '',
                  needPrefix: 3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
