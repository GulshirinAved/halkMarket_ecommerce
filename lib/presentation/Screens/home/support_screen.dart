import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/webview/webview_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.leadingTitle(
        title:
            AppLocalization.of(context).getTransatedValues('helpAndInfo') ?? '',
        centerTitle: true,
        needBoxshadow: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.grey2Color,
          borderRadius: AppBorders.borderRadius12,
        ),
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () => pushScreen(
                context,
                screen: WebViewScreen(
                  path: helpList[index]['path'],
                  topTitle: AppLocalization.of(context)
                          .getTransatedValues(helpList[index]['title']) ??
                      '',
                ),
              ),
              leading: SvgPicture.asset(helpList[index]['icon']),
              title: Text(
                AppLocalization.of(context)
                        .getTransatedValues(helpList[index]['title']) ??
                    '',
                style: TextStyle(
                  color: AppColors.darkPurpleColor,
                  fontWeight: FontWeight.w400,
                  fontSize: AppFonts.fontSize16,
                ),
              ),
              trailing: SvgPicture.asset(arrowRightIcon),
            );
          },
          separatorBuilder: (context, index) {
            return index == helpList.length - 1
                ? const SizedBox.shrink()
                : Divider(
                    endIndent: 10,
                    indent: 10,
                    color: AppColors.grey5Color,
                  );
          },
          itemCount: helpList.length,
        ),
      ),
    );
  }
}
