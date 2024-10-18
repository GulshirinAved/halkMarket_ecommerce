import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class SettingsCards extends StatelessWidget {
  const SettingsCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.grey2Color,
        borderRadius: AppBorders.borderRadius20,
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            pushScreenWithoutNavBar(context, settingsCards[index]['screen']);
          },
          leading: SvgPicture.asset(settingsCards[index]['icon']),
          title: Text(
            AppLocalization.of(context)
                    .getTransatedValues(settingsCards[index]['title']) ??
                '',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: AppFonts.fontSize16,
              color: AppColors.darkPurpleColor,
            ),
          ),
          trailing: SvgPicture.asset(arrowRightIcon),
        ),
        separatorBuilder: (context, index) => Divider(
          color: AppColors.grey5Color,
          endIndent: 15,
          indent: 15,
        ),
        itemCount: settingsCards.length,
      ),
    );
  }
}
