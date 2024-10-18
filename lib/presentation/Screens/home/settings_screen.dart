import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/auth/removeAccaunt/remove_accaunt_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/auth/userProfile/user_profile_bloc.dart';

import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/data/models/updateUserData_model.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/settings_cards.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/splash/splash_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RemoveAccauntBloc(),
        ),
        BlocProvider.value(
          value: UserProfileBloc()..add(GetUserData()),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar.leadingTitle(
              title:
                  AppLocalization.of(context).getTransatedValues('setting') ??
                      '',
              needBoxshadow: false,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Card with Name
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(4, 4),
                          blurRadius: 15,
                          color: AppColors.grey3Color.withOpacity(0.35),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        personIcon(),
                        BlocBuilder<UserProfileBloc, UserProfileState>(
                          builder: (context, state) {
                            final Data? userData = state is UserProfileLoaded
                                ? state.userData
                                : null;
                            print(userData);
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 12, bottom: 30),
                              child: Text(
                                userData?.name ??
                                    AppLocalization.of(context)
                                        .getTransatedValues('noName') ??
                                    '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: fontExo2,
                                  fontWeight: FontWeight.w600,
                                  fontSize: AppFonts.fontSize18,
                                  color: AppColors.darkPurpleColor,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SettingsCards(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomButton.withIconText(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      borderRadius: AppBorders.borderRadius12,
                      width: MediaQuery.of(context).size.width,
                      backColor: AppColors.grey2Color,
                      textColor: AppColors.darkPurpleColor,
                      fontSize: AppFonts.fontSize16,
                      title: AppLocalization.of(context)
                              .getTransatedValues('logout') ??
                          '',
                      fontweight: FontWeight.w400,
                      onTap: () {
                        context
                            .read<RemoveAccauntBloc>()
                            .add(RemoveAccauntSubmitted());
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SplashScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      icon: logoutIcon,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Container personIcon() {
    return Container(
      height: 60,
      width: 60,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        userIcon,
        fit: BoxFit.cover,
      ),
    );
  }
}
