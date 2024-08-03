import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/login_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.leadingTitle(
        title: AppLocalization.of(context).getTransatedValues('profile') ?? '',
      ),
      body: ListView(
        children: [
          const LoginCard(),
          ProfileCard(
            cardList: profileCard,
          ),
          ProfileCard(
            cardList: profile2Card,
            isArrow: false,
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final List cardList;
  final bool? isArrow;
  const ProfileCard({
    required this.cardList,
    this.isArrow = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: AppBorders.borderRadius12,
        color: AppColors.grey2Color,
      ),
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => ListTile(
          minTileHeight: 34.h,
          leading: SvgPicture.asset(
            cardList[index]['icon'],
          ),
          title: Text(
            AppLocalization.of(context).getTransatedValues(
                  cardList[index]['title'],
                ) ??
                '',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: AppFonts.fontSize12,
              color: AppColors.darkPurpleColor,
            ),
          ),
          trailing: index == 0 && cardList == profile2Card && isArrow == false
              ? SizedBox()
              : SvgPicture.asset(arrowRightIcon),
        ),
        separatorBuilder: (context, index) => Divider(
          color: AppColors.grey5Color,
        ),
        itemCount: cardList.length,
      ),
    );
  }
}
