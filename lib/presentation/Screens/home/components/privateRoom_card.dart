import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/auth/userProfile/user_profile_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/data/models/updateUserData_model.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/settings_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class PrivateCard extends StatelessWidget {
  const PrivateCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pushScreenWithoutNavBar(context, const SettingsScreen()),
      child: Container(
        padding: const EdgeInsets.only(left: 20),
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
        child: ListTile(
          contentPadding: const EdgeInsets.only(top: 10, bottom: 5),
          leading: IconButton.filled(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(AppColors.greyColor),
            ),
            icon: SvgPicture.asset(userIcon),
          ),
          title: BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, state) {
              final Data? userdata =
                  state is UserProfileLoaded ? state.userData : null;
              final String displayName = userdata?.name ??
                  AppLocalization.of(context).getTransatedValues('noName') ??
                  '';
              return Text(
                displayName,
                style: TextStyle(
                  fontFamily: fontExo2,
                  fontWeight: FontWeight.w600,
                  fontSize: AppFonts.fontSize18,
                  color: AppColors.darkPurpleColor,
                ),
              );
            },
          ),
          subtitle: Row(
            children: [
              Text(
                AppLocalization.of(context).getTransatedValues('setting') ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: AppFonts.fontSize12,
                  color: AppColors.darkPurpleColor,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              SvgPicture.asset(
                arrowRightIcon,
                colorFilter: ColorFilter.mode(
                  AppColors.purpleColor,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
