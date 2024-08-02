import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';

class DeliveryAddressTile extends StatelessWidget {
  const DeliveryAddressTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,

      //leading profile picture
      leading: IconButton.filled(
        onPressed: () {},
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.greyColor)),
        icon: SvgPicture.asset(userIcon),
      ),
      // add delivery address  button
      title: GestureDetector(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalization.of(context)
                      .getTransatedValues('addDeliveryAddress') ??
                  '',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: AppFonts.fontSize14,
                color: AppColors.darkPurpleColor,
              ),
            ),
            SvgPicture.asset(arrowRightIcon),
          ],
        ),
      ),
      trailing: SvgPicture.asset(locationIcon),
    );
  }
}
