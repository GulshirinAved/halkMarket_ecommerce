import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/map/addDeliveryLocation/location_add_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/location_bottomsheets.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/profile_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class DeliveryAddressTile extends StatelessWidget {
  const DeliveryAddressTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,

      //leading profile picture
      leading: GestureDetector(
        onTap: () {
          pushScreenWithoutNavBar(context, const ProfileScreen());
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.greyColor,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(userIcon),
        ),
      ),
      // add delivery address  button
      title: GestureDetector(
        onTap: () {
          LocationBottomsheet().addAddressBottomsheet(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<LocationAddBloc, LocationAddState>(
              builder: (context, state) {
                log('here it is home page ${state.selectedRadioValue.toString()}');
                return Flexible(
                  child: Text(
                    state.selectedRadioValue != ''
                        ? state.selectedRadioValue
                        : AppLocalization.of(context)
                                .getTransatedValues('addDeliveryAddress') ??
                            '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: AppFonts.fontSize15,
                      color: AppColors.darkPurpleColor,
                    ),
                  ),
                );
              },
            ),
            SvgPicture.asset(arrowRightIcon),
          ],
        ),
      ),
      trailing: GestureDetector(
        onTap: () {},
        child: SvgPicture.asset(locationIcon),
      ),
    );
  }
}
